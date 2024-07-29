//
//  ServiceImpl.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/7/24.
//

import Foundation


public protocol Requestable {
    var requestTimeout: Float { get }
    func request(_ req: RequestModel, completionHandler: @escaping ([String: Any]?, NetworkError?) -> ())
}

public class NetworkRequestable: Requestable {
    public var requestTimeout: Float = 30
    
    public func request(_ req: RequestModel, completionHandler: @escaping ([String: Any]?, NetworkError?) -> ()){
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(req.requestTimeout ?? requestTimeout)

        guard let urlRequest = req.getUrlRequest() else {
            completionHandler(nil, NetworkError.apiError(code: 0, error: "Error encoding http body"))
            return
        }
//        
        appLog(tag: .debug, "Request = \(urlRequest)")
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard response is HTTPURLResponse, let response = response as? HTTPURLResponse else {
                completionHandler(nil, NetworkError.noResponse("Invalid Response"))
                return
            }
            
            guard let dataUnw = data else {
                print(String(describing: error))
                return
            }
            
            if (200..<300) ~= response.statusCode {
                appLog(tag: .debug, "Request Succesfull: code = \(response.statusCode)")
                if let dataStr = String(data: dataUnw, encoding: .utf8) {
                    appLog(tag: .debug, "Request Succesfull: data = \(dataStr)")
                    print("Dictionary format: \(dataStr)")
                    let dict = self.convertToDictionary(text: dataStr)
                    completionHandler(dict, nil)
                }
            } else if (300..<400) ~= response.statusCode {
                completionHandler(nil, NetworkError.redirection(code: response.statusCode, error: "Redirection"))
                return
            } else if (400..<500) ~= response.statusCode {
                appLog(tag: .warning, "CLIENT ERROR: code = \(response.statusCode)")
                completionHandler(nil, NetworkError.clientError(code: response.statusCode, error: "Client error"))
                return
            } else if (500..<600) ~= response.statusCode {
                appLog(tag: .error, "SERVER ERROR: code = \(response.statusCode)")
                completionHandler(nil, NetworkError.serverError(code: response.statusCode, error: "Server error"))
                return
            }
            
        }
        task.resume()
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}


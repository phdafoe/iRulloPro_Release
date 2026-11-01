//
//  ServiceImpl.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/7/24.
//

import Foundation


public protocol Requestable {
    var requestTimeout: Float { get }
    func request(
        _ req: RequestModel,
        completionHandler: @escaping ([String: Any]?, NetworkError?) -> ()
    )
}

public final class NetworkRequestable: Requestable {
    public var requestTimeout: Float = 30

    public func request(
        _ req: RequestModel,
        completionHandler: @escaping ([String: Any]?, NetworkError?) -> ()
    ) {
        guard let urlRequest = req.getUrlRequest() else {
            completeOnMain(
                data: nil,
                error: .apiError(code: 0, error: "Error encoding HTTP body"),
                tracksActivity: false,
                completionHandler: completionHandler
            )
            return
        }

        DispatchQueue.main.async {
            NetworkActivityController.shared.beginRequest()
        }

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(req.requestTimeout ?? requestTimeout)
        let session = URLSession(configuration: configuration)
        appLog(tag: .debug, "Request = \(urlRequest)")

        session.dataTask(with: urlRequest) { data, response, error in
            if let urlError = error as? URLError {
                self.completeOnMain(
                    data: nil,
                    error: .transportError(
                        code: urlError.errorCode,
                        error: urlError.localizedDescription
                    ),
                    completionHandler: completionHandler
                )
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                self.completeOnMain(
                    data: nil,
                    error: .noResponse("Invalid response"),
                    completionHandler: completionHandler
                )
                return
            }

            guard let responseData = data else {
                self.completeOnMain(
                    data: nil,
                    error: .unableToParseData("The response did not contain data"),
                    completionHandler: completionHandler
                )
                return
            }

            switch httpResponse.statusCode {
            case 200..<300:
                appLog(tag: .debug, "Request successful: code = \(httpResponse.statusCode)")
                guard let dictionary = self.convertToDictionary(data: responseData) else {
                    self.completeOnMain(
                        data: nil,
                        error: .invalidJSON("The response is not a JSON object"),
                        completionHandler: completionHandler
                    )
                    return
                }
                self.completeOnMain(data: dictionary, error: nil, completionHandler: completionHandler)
            case 300..<400:
                self.completeOnMain(
                    data: nil,
                    error: .redirection(code: httpResponse.statusCode, error: "Redirection"),
                    completionHandler: completionHandler
                )
            case 400..<500:
                appLog(tag: .warning, "CLIENT ERROR: code = \(httpResponse.statusCode)")
                self.completeOnMain(
                    data: nil,
                    error: .clientError(code: httpResponse.statusCode, error: "Client error"),
                    completionHandler: completionHandler
                )
            case 500..<600:
                appLog(tag: .error, "SERVER ERROR: code = \(httpResponse.statusCode)")
                self.completeOnMain(
                    data: nil,
                    error: .serverError(code: httpResponse.statusCode, error: "Server error"),
                    completionHandler: completionHandler
                )
            default:
                self.completeOnMain(
                    data: nil,
                    error: .invalidResponse(
                        code: httpResponse.statusCode,
                        error: "Unexpected status code"
                    ),
                    completionHandler: completionHandler
                )
            }
        }
        .resume()
    }

    private func completeOnMain(
        data: [String: Any]?,
        error: NetworkError?,
        tracksActivity: Bool = true,
        completionHandler: @escaping ([String: Any]?, NetworkError?) -> ()
    ) {
        DispatchQueue.main.async {
            if tracksActivity {
                NetworkActivityController.shared.endRequest()
            }
            completionHandler(data, error)
        }
    }

    private func convertToDictionary(data: Data) -> [String: Any]? {
        try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    }
}

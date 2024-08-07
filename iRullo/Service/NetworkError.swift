//
//  NetworkError.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 19/7/24.
//

import Foundation

public enum NetworkError: Error, Equatable {
    case redirection(code: Int, error: String)
    case clientError(code: Int, error: String)
    case serverError(code: Int, error: String)
    case badURL(_ error: String)
    case apiError(code: Int, error: String)
    case invalidJSON(_ error: String)
    case unauthorized(code: Int, error: String)
    case badRequest(code: Int, error: String)
    case noResponse(_ error: String)
    case unableToParseData(_ error: String)
    case invalidResponse(code: Int, error: String)
    case transportError(code: Int, error: String)
    case unknown(_ error: String)
}

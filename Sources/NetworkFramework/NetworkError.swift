//
//  NetworkError.swift
//
//
//  Created by lucas.r.rebelato on 14/05/21.
//

import Foundation

public enum NetworkError: Int, Error {
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFount = 404
    case notAllowed = 405
    case unsupportedMedia = 415
    case limitExceeded = 429
    case internalError = 500
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    case parseError = 600
}

//
//  NetworkHandler.swift
//  
//
//  Created by lucas.r.rebelato on 14/05/21.
//

import Foundation

public protocol NetworkHandlerProtocol {
    func request<T: Decodable>(with url: String, completion: @escaping (Result<T, NetworkError>) -> Void)
}

public class NetworkHandler: NetworkHandlerProtocol {
    
    public let service: NetworkServiceProtocol
    
    public init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
    }

    public func request<T: Decodable>(with url: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        service.request(with: url) { (data, response, error) in
            completion(self.handleResult(data: data, response: response, error: error))
        }
    }
    
    private func handleResult<T: Decodable>(data: Data?, response: URLResponse?, error: Error?) -> (Result<T, NetworkError>) {
        
        if error != nil, let httpResponse = response as? HTTPURLResponse {
            return .failure(NetworkError(rawValue: httpResponse.statusCode) ?? NetworkError.badRequest)
        }
        
        if let data = data {
            do {
                let decode = try JSONDecoder().decode(T.self, from: data)
                return .success(decode)
            } catch {
                print(error.localizedDescription)
                return .failure(.parseError)
            }
        }
        
        return .failure(.badRequest)
    }
    
}

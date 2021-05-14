//
//  NetworkService.swift
//  
//
//  Created by lucas.r.rebelato on 14/05/21.
//

import Foundation

public typealias DataResponse = (Data?, URLResponse?, Error?) -> Void

public protocol NetworkServiceProtocol {
    func request(with requestString: String, completion: @escaping(DataResponse))
}

public class NetworkService: NetworkServiceProtocol {

    private let service: URLSession
    
    public init(service: URLSession = URLSession.shared) {
        self.service = service
    }
    
    public func request(with endpoint: String, completion: @escaping(DataResponse)) {
        guard let url = URL(string: endpoint) else {
            completion(nil, nil, NetworkError.badRequest)
            return
        }
        
        service.dataTask(with: url, completionHandler: completion).resume()
    }
    
}

//
//  ServiceLayer.swift
//  AgencySearch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 01/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import Foundation

class ServiceLayer {
    
    class func request<T: Codable>(router: Endpoint, parameters: [URLQueryItem], completion: @escaping (Result<T, Error>) -> ()) {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = parameters
        
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method

        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard response != nil else { return }
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch (let err) {
                completion(.failure(NetworkError.jsonDecodingError(error: err)))
            }
        }
        dataTask.resume()
    }
}

enum NetworkError: Error {
    case failedToDownload
    case jsonDecodingError(error: Error)
}

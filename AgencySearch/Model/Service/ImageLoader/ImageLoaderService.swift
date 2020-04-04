//
//  ImageLoader.swift
//  AgencySearch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 03/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import Foundation
import UIKit.UIImage
import Combine

class ImageLoaderService {
    
    static func loadImage(from router: Endpoint, parameters: [URLQueryItem], completion: @escaping (Result<UIImage?, Error>) -> Void) {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = parameters
        
        guard let url = components.url else { return }
        
        if let image = ImageCache().shared.image(for: url) {
            completion(.success(image))
        }
        URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                guard let image = UIImage(data: data) else { return }
                ImageCache().shared.insertImage(image, for: url)
                completion(.success(image))
            } else {
                completion(.failure(NetworkError.failedToDownload))
            }
        }.resume()
    }
}

//
//  JsonPlaceholderProvider.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 25/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import Foundation

struct Placeholder: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

final class JsonPlaceholderProvider {
    
    private let baseUrl = URL(string: "https://jsonplaceholder.typicode.com")
    
    func fetch<T: Codable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let fullUrl = baseUrl?.appendingPathComponent(url) else {
            return
        }
        
        URLSession.shared.dataTask(with: fullUrl) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            do {
                if let data = data  {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                }
            } catch let err {
                completion(.failure(err))
            }
        }.resume()
        
    }
    
}

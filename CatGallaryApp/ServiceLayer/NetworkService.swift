//
//  NetworkService.swift
//  CatGallaryApp
//
//  Created by Vlad on 24.05.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getCats(completion: @escaping (Result<[Cat]?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getCats(completion: @escaping (Result<[Cat]?, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let object = try JSONDecoder().decode([Cat].self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
    


//
//  NetworkService.swift
//  CatGallaryApp
//
//  Created by Vlad on 24.05.2023.
//

import Foundation

/**
 The NetworkServiceProtocol is a protocol that defines the methods required for downloading JSON data and cat photos from a network service
 */
protocol NetworkServiceProtocol {
    func downloadJSON(completion: @escaping (Result<[Cat]?, Error>) -> Void)
    func downloadPhotos(for cats: [Cat], completion: @escaping (Result<[CatPhoto]?, Error>) -> Void)
}

/**
 The NetworkService class implements the NetworkServiceProtocol.
 It provides the actual implementation for downloading JSON data and cat photos from a network service using URLSession
 */
class NetworkService: NetworkServiceProtocol {
    
    /**
     This method creates a URLSessionDataTask to download JSON data from a specified URL.
     Upon completion, it decodes the JSON data into an array of Cat objects using JSONDecoder. The result is then passed to the provided completion closure.
     */
    func downloadJSON(completion: @escaping (Result<[Cat]?, Error>) -> Void) {
        guard let url = URL(string: catApiUrlString) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])))
                return
            }
            
            do {
                let object = try JSONDecoder().decode([Cat].self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    /**
     This method uses a dispatch group to download cat photos for each Cat object in the provided array.
     It creates a URLSessionDataTask for each URL and appends the downloaded photos to an array of CatPhoto objects.
     Once all the download tasks have completed, the array of CatPhoto objects is passed to the completion closure.
     */
    func downloadPhotos(for cats: [Cat], completion: @escaping (Result<[CatPhoto]?, Error>) -> Void) {
        var catPhotos = [CatPhoto]()
        let group = DispatchGroup()
        
        for cat in cats {
            group.enter()
            
            guard let url = URL(string: cat.url) else {
                group.leave()
                continue
            }
            
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                defer { group.leave() }
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let data = data {
                    let catPhoto = CatPhoto(dataImage: data)
                    catPhotos.append(catPhoto)
                }
            }.resume()
        }
        
        group.notify(queue: .main) {
            completion(.success(catPhotos))
        }
    }
}

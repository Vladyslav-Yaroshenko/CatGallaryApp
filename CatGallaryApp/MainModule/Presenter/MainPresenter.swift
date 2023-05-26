//
//  MainPresenter.swift
//  CatGallaryApp
//
//  Created by Vlad on 24.05.2023.
//

import Foundation

/**
 The MainViewProtocol protocol defines the interface for the main view in the Cat Gallery app.
 It provides methods that the view should implement to handle success and failure scenarios.
 */
protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

/**
The MainViewPresenterProtocol protocol defines the interface for the presenter of the main view in the Cat Gallery app.
 It provides methods and properties that the presenter should implement to handle business logic related to the main view.
*/
protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    
    var cats: [Cat]? { get set }
    var catPhotos: [CatPhoto]? { get set }
    func getCats()
}

/**
The MainPresenter class implements the MainViewPresenterProtocol and serves as the presenter for the main view in the Cat Gallery app.

It manages the communication between the view and the network service, retrieves the cat data, and downloads the cat photos.
 It also handles success and failure scenarios.
*/
class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol!
    var cats: [Cat]?
    var catPhotos: [CatPhoto]?
    
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getCats()
    }
    
    // Retrieves the list of cats and their photos from the network service.
    func getCats() {
        networkService.downloadJSON { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let cats):
                    self.cats = cats
                    self.downloadCatPhotos()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    // Downloads the cat photos for the retrieved cat objects.
    private func downloadCatPhotos() {
        guard let cats = cats else {
            return
        }

        networkService.downloadPhotos(for: cats) { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let catPhotos):
                    self.catPhotos = catPhotos
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}

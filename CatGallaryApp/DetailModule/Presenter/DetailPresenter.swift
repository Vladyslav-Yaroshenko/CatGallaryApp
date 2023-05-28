//
//  DetailPresenter.swift
//  CatGallaryApp
//
//  Created by Vlad on 28.05.2023.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func setCatPhoto(image: CatPhoto?)
    // func setCatInfo(cat: Cat?)
}

protocol DetailViewPresenterProtocol: AnyObject {
    
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, cat: Cat?, photo: CatPhoto?)
    func setPhoto()
}

class DetailPresenter: DetailViewPresenterProtocol {
   
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol!
    var cat: Cat?
    var catPhoto: CatPhoto?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, cat: Cat?, photo: CatPhoto?) {
        self.view = view
        self.networkService = networkService
        self.cat = cat
        self.catPhoto = photo
    }
    
    public func setPhoto() {
        self.view?.setCatPhoto(image: catPhoto)
    }
    
    
}

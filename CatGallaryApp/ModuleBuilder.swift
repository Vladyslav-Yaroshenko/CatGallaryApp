//
//  ModuleBuilder.swift
//  CatGallaryApp
//
//  Created by Vlad on 24.05.2023.
//

import Foundation
import UIKit

/**
 The Builder protocol is a protocol that defines methods for creating modules in an application.
 It defines that any type conforming to this protocol must be able to create and return a UIViewController object.
 */
protocol Builder {
    static func createMainModule() -> UIViewController
}

/**
 The ModuleBuilder class is a concrete implementation of the Builder protocol.
 It provides the implementation for creating the modules in the application.
 */
class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
       
        let view =  MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
}

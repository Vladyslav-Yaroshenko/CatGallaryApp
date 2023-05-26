//
//  Constants.swift
//  CatGallaryApp
//
//  Created by Vlad on 24.05.2023.
//

import UIKit

/**
 Constants and variables used to adjust the size and position of the CollectionViewCell
 */
var defaultItemsPerRow: CGFloat = 2
let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
let interitemSpacing: CGFloat = 20
let lineSpacing: CGFloat = 20

/**
 A private constant storing the API key used for the CatAPI service. It is a string value.
 */
private let apiKey = "live_K0N0b0lgmHjiZDqirNDeenHBkgI6NsjFaj0pXD4OttMvBXubjQtKNcwjO1EnQFDy"

/**
 Variable that contains the URL for making a request to the CatAPI. It includes the API key as a parameter to retrieve specific data from the API.
 */
let catApiUrlString = "https://api.thecatapi.com/v1/images/search?limit=30&api_key=\(apiKey)"

//
//  CatPhoto.swift
//  CatGallaryApp
//
//  Created by Vlad on 25.05.2023.
//

import Foundation
import UIKit

/**
 A struct representing a cat photo.

 The CatPhoto struct represents a cat photo in the Cat Gallery app.
 It contains a dataImage property that holds the binary data of the photo.
 The struct provides an initializer to set the dataImage property with the given binary data.
 */
struct CatPhoto {
    let dataImage: Data

    init(dataImage: Data) {
        self.dataImage = dataImage
    }

    var image: UIImage? {
        return UIImage(data: dataImage)
    }
}

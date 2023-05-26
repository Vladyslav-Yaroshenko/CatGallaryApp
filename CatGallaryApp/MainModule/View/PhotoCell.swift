//
//  PhotoCell.swift
//  CatGallaryApp
//
//  Created by Vlad on 25.05.2023.
//

import UIKit

/**
 Custom UICollectionViewCell for displaying photos.

 The PhotoCell class represents a custom collection view cell used for displaying photos in the Cat Gallery app.
 It inherits from UICollectionViewCell and provides a UIImageView outlet for displaying the actual photo.
 */
class PhotoCell: UICollectionViewCell {

    // The image view used to display the photo.
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure the appearance of the image view
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
    }

}

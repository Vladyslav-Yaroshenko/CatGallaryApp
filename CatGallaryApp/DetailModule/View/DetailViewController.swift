//
//  DetailViewController.swift
//  CatGallaryApp
//
//  Created by Vlad on 28.05.2023.
//

import UIKit

class DetailViewController: UIViewController {

    var imageView: UIImageView!
    var shareButton: UIButton!
    
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupImageView()
        setupShareButton()
        presenter.setPhoto()
    }


    private func setupImageView() {
        let width = view.frame.width
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        imageView.center = view.center
        view.addSubview(imageView)
    }
    
    private func setupShareButton() {
        let color = UIColor { traitCollection -> UIColor in
            return traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
        shareButton = UIButton(type: .system)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.setTitle("Tap to share", for: .normal)
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.setTitleColor(color, for: .normal)
        shareButton.tintColor = color
        
        view.addSubview(shareButton)
        
        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: interitemSpacing),
            shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    }
    
    @objc private func shareButtonTapped() {
            
    }

}

extension DetailViewController: DetailViewProtocol {
    func setCatPhoto(image: CatPhoto?) {
        self.imageView.image = image?.image
        self.imageView.contentMode = .scaleAspectFit
    }
}

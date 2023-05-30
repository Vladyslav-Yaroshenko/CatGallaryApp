//
//  DetailViewController.swift
//  CatGallaryApp
//
//  Created by Vlad on 28.05.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Variables
    var imageView: UIImageView!
    var shareButton: UIButton!
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupImageView()
        setupShareButton()
        setupConstraints()
        presenter.setPhoto()
    }

    /**
     The setupImageView() function is responsible for setting up the imageView in the view hierarchy of the view controller.
     */
    private func setupImageView() {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
    }
    
    /**
     The setupShareButton() function is responsible for setting up the shareButton in the view hierarchy of the view controller.
     */
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
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        view.addSubview(shareButton)
    }
    
    /**
     The setupConstraints() function is responsible for applying Auto Layout constraints to the imageView and shareButton within the view controller's view.
     */
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            shareButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: interitemSpacing),
            shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    /**
     The shareButtonTapped() method is an action triggered when the user taps on the shareButton.
     It creates a UIActivityViewController to share the image displayed in the imageView.
     The popoverPresentationController is configured to show the activity view from either the shareButton or the view itself, depending on their availability.
     The UIActivityViewController is then presented modally with animation.
     */
    @objc private func shareButtonTapped() {
        guard let image = imageView.image else { return }
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        if let popoverPresentationController = activityViewController.popoverPresentationController {
            if let sourceView = shareButton ?? view {
                popoverPresentationController.sourceView = sourceView
                popoverPresentationController.sourceRect = sourceView.bounds
                popoverPresentationController.permittedArrowDirections = [.any]
            }
        }
        present(activityViewController, animated: true, completion: nil)
    }
}

//MARK: - DetailViewProtocol
extension DetailViewController: DetailViewProtocol {
    func setCatPhoto(image: CatPhoto?) {
        self.imageView.image = image?.image
        self.imageView.contentMode = .scaleAspectFit
    }
}

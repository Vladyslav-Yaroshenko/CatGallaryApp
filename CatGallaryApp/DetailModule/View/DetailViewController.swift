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
        setupConstraints()
        presenter.setPhoto()
    }


    private func setupImageView() {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        view.addSubview(shareButton)
    }
    
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

extension DetailViewController: DetailViewProtocol {
    func setCatPhoto(image: CatPhoto?) {
        self.imageView.image = image?.image
        self.imageView.contentMode = .scaleAspectFit
    }
}

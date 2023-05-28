//
//  DetailViewController.swift
//  CatGallaryApp
//
//  Created by Vlad on 28.05.2023.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.setPhoto()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: DetailViewProtocol {
    func setCatPhoto(image: CatPhoto?) {
        self.imageView.image = image?.image
    }
    
    
}

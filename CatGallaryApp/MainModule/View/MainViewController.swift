//
//  ViewController.swift
//  CatGallaryApp
//
//  Created by Vlad on 24.05.2023.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: MainViewPresenterProtocol!
    var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSegmentControl()
        setupCell()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    private func initSegmentControl() {
        segmentControl = UISegmentedControl(items: ["1", "2", "3"])
        segmentControl.selectedSegmentIndex = 1
        segmentControl.selectedSegmentTintColor = .systemBlue
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        
        let barButtonItem = UIBarButtonItem(customView: segmentControl)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func segmentControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0 :
            defaultItemsPerRow = 1
        case 1 :
            defaultItemsPerRow = 2
        case 2 :
            defaultItemsPerRow = 3
        default: break
        }
        setupCell()
    }
    
    func setupCell() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = {
            let paddingWidth = sectionInsets.left * (defaultItemsPerRow + 1)
            let availableWidth = view.frame.width - paddingWidth
            let cellWidth = Int(availableWidth / defaultItemsPerRow)
            return CGSize(width: cellWidth, height: cellWidth)
        }()
        layout.sectionInset = sectionInsets
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = interitemSpacing
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.cats?.count ?? 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .orange
        
        return cell
    }
}



extension MainViewController: MainViewProtocol {
    func success() {
        collectionView.reloadData()
    }
    
    func failure(error: Error) {
        let alertController = UIAlertController(title: "Error", message:  "no internet connection", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    
}


//
//  ViewController.swift
//  CatGallaryApp
//
//  Created by Vlad on 24.05.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Variables
    var presenter: MainViewPresenterProtocol!
    var segmentControl: UISegmentedControl!
    var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegmentControlBarItem()
        setupReloadBarButtonItem()
        setupActivityIndicator()
        
        let nibCell = UINib(nibName: "PhotoCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "Cell")
        
        setSegmentControlAndCollectionViewVisibility(hidden: true)
    }
    
    //MARK: - Funcs
    
    /**
     Sets the visibility of the segment control and collection view.
     This function is commonly used to control the visibility of these UI elements during certain states or actions, such as when data is being loaded or refreshed.
     */
    private func setSegmentControlAndCollectionViewVisibility(hidden: Bool) {
        segmentControl.isHidden = hidden
        collectionView.isHidden = hidden
    }
    
    /**
     Sets up the activity indicator.

     This private function is responsible for initializing and configuring the activity indicator.
     It creates an instance of UIActivityIndicatorView with the large style, adds it as a subview to the view controller's view, and sets up auto layout constraints to center it within the view.
     The activity indicator is set to hide when stopped, and it starts animating immediately after setup.
     This function is typically called during the initial setup of the view controller to indicate that some operation is in progress.
     */
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    
    /**
     Sets up the segment control as a custom bar item.

     This private function is responsible for configuring the segment control as a custom bar item and adding it to the navigation bar.
     It creates an instance of UISegmentedControl with the provided segment items and initial selected index.
     The segment control's appearance is customized by setting the selected segment tint color to .systemBlue.
     Additionally, a target-action is set up to trigger the segmentControlValueChanged(_:) method when the selected segment value changes.
     The segment control is then wrapped in a UIBarButtonItem with a custom view and assigned to the right bar button item of the navigation bar.
     */
    private func setupSegmentControlBarItem() {
        segmentControl = UISegmentedControl(items: ["1", "2", "3"])
        segmentControl.selectedSegmentIndex = 1
        segmentControl.selectedSegmentTintColor = .systemBlue
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        
        let barButtonItem = UIBarButtonItem(customView: segmentControl)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    /**
     Handles the value change event of the segmented control.
      
     This function is triggered when the selected segment of the segmented control is changed.
     It updates the `defaultItemsPerRow` property based on the selected segment index, which determines the desired number of items per row in the collection view.
     After updating the property, it calls the `configureCollectionViewCellLayout()` function to adjust the layout of the collection view cells according to the new value of `defaultItemsPerRow`.
     */
    @objc private func segmentControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0 :
            defaultItemsPerRow = 1
        case 1 :
            defaultItemsPerRow = 2
        case 2 :
            defaultItemsPerRow = 3
        default: break
        }
        configureCollectionViewCellLayout()
    }
    
    /**
     Sets up the reload bar button item.

     This private function is responsible for creating and configuring the reload bar button item.
     It creates an instance of UIBarButtonItem with the system refresh button style, sets the target to self (the view controller), and assigns the action to the tappedReloadButton method.
     The bar button item is then assigned to the left bar button item of the navigation bar.
     */
    private func setupReloadBarButtonItem() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(tappedReloadButton))
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    /**
     Handles the tap event of the reload button.
      
     This function is triggered when the reload button is tapped. It initiates the process of fetching new cat data by calling the `presenter.getCats()` method. Before making the request, it starts animating the activity indicator and hides the segment control and collection view to indicate that data is being loaded.
     */
    @objc private func tappedReloadButton() {
        activityIndicator.startAnimating()
        setSegmentControlAndCollectionViewVisibility(hidden: true)
        presenter.getCats()
    }
    
    /**
     Configures the layout of the collection view cells.
      
     This function adjusts the size, spacing, and scrolling direction of the collection view cells.
     It calculates the item size based on the available width and the desired number of items per row.
     Additionally, it sets the section insets, line spacing, and interitem spacing of the collection view layout.
     After applying the layout changes, it invalidates the collection view's layout to ensure the changes take effect.
     */
    private func configureCollectionViewCellLayout() {
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

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.cats?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCell
        cell.imageView.image = presenter.catPhotos?[indexPath.row].image
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = presenter.catPhotos?[indexPath.row]
        let cat = presenter.cats?[indexPath.row]
        
        let detailVC = ModuleBuilder.createDetailModule(cat: cat, photo: photo)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    
    /**
     This function handles the UI updates after the successful loading and processing of data,
     providing a smooth user experience and displaying the retrieved data in the collection view.
     */
    func success() {
        configureCollectionViewCellLayout()
        collectionView.reloadData()
        activityIndicator.stopAnimating()
        setSegmentControlAndCollectionViewVisibility(hidden: false)
    }
    
    /**
     The failure(error: Error) function is responsible for handling errors that occur during the data retrieval or processing.
     It presents an alert controller with an error message to inform the user about the failure.
     The error message states that the data failed to load and prompts the user to try again by providing a "Reload" action.
     When the "Reload" action is tapped, the presenter.getCats() method is called to initiate another attempt at fetching the data.
     Overall, this function provides user-friendly error handling and allows the user to easily retry loading the data.
     */
    func failure(error: Error) {
        let alertController = UIAlertController(title: "Error", message: "Failed to load data. Please try again.", preferredStyle: .alert)
        let reloadAction = UIAlertAction(title: "Reload", style: .default) { [weak self] _ in
            self?.presenter.getCats()
        }
        alertController.addAction(reloadAction)
        present(alertController, animated: true)
    }
}


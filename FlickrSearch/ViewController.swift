//
//  ViewController.swift
//  FlickrSearch
//
//  Created by Nivesh on 28/06/20.
//  Copyright © 2020 Nivesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  private var searchBarController: UISearchController!
  private var numberOfColumns: CGFloat = FlickrConstants.defaultColumnCount
  private var viewModel = FlickrViewModel()
  private var isFirstTimeActive = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    viewModelClosures()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if isFirstTimeActive {
      //searchBarController.isActive = true
      isFirstTimeActive = false
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  private func showAlert(title: String = "Flickr", message: String?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title:NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {(action) in
    }
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
}

//MARK:- Configure UI
extension ViewController {
  
  fileprivate func configureUI() {
    // Do any additional setup after loading the view, typically from a nib.
    
    createSearchBar()
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationItem.largeTitleDisplayMode = .always
    
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(nib: ImageCollectionViewCell.nibName)
  }
}

//MARK:- Clousers
extension ViewController {
  
  fileprivate func viewModelClosures() {
    
    viewModel.showAlert = { [weak self] (message) in
      self?.searchBarController.isActive = false
      self?.showAlert(message: message)
    }
    
    viewModel.dataUpdated = { [weak self] in
      print("data source updated")
      self?.collectionView.reloadData()
    }
  }
  
  private func loadNextPage() {
    viewModel.fetchNextPage {
      print("next page fetched")
    }
  }
}

extension ViewController: UISearchControllerDelegate, UISearchBarDelegate {
  
  private func createSearchBar() {
    searchBarController = UISearchController(searchResultsController: nil)
    self.navigationItem.searchController = searchBarController
    searchBarController.delegate = self
    searchBarController.searchBar.delegate = self
    searchBarController.obscuresBackgroundDuringPresentation = false
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    guard let text = searchBar.text, text.count > 1 else {
      return
    }
    
    collectionView.reloadData()
    
    viewModel.search(text: text) {
      print("search completed.")
    }
    
    searchBarController.searchBar.resignFirstResponder()
  }
}

//MARK:- UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.photoArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.nibName, for: indexPath) as! ImageCollectionViewCell
    cell.imageView.image = nil
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard let cell = cell as? ImageCollectionViewCell else {
      return
    }
    
    let model = viewModel.photoArray[indexPath.row]
    cell.model = ImageModel.init(withPhotos: model)
    
    if indexPath.row == (viewModel.photoArray.count - 10) {
      loadNextPage()
    }
  }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (collectionView.bounds.width)/numberOfColumns, height: (collectionView.bounds.width)/numberOfColumns)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}


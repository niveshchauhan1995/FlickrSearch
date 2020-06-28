//
//  Extensions.swift
//  FlickrSearch
//
//  Created by Nivesh on 28/06/20.
//  Copyright © 2020 Nivesh. All rights reserved.
//

import UIKit

//MARK:- UICollectionView
extension UICollectionView {
    func register(nib nibName: String) {
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
}

//MARK:- UIImageView
extension UIImageView {
    
    func downloadImage(_ url: String) {
        
        ImageDownloadManager.shared.addOperation(url: url,imageView: self) {  [weak self](result,downloadedImageURL)  in
            GCD.runOnMainThread {
                switch result {
                case .Success(let image):
                    self?.image = image
                case .Failure(_):
                    break
                case .Error(_):
                    break
                }
            }
        }
    }
}

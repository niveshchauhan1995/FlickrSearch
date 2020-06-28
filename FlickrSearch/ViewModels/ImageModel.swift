//
//  ImageModel.swift
//  FlickrSearch
//
//  Created by Nivesh on 28/06/20.
//  Copyright © 2020 Nivesh. All rights reserved.
//

import Foundation

struct ImageModel {

    let imageURL: String
    
    init(withPhotos photo: FlickrPhoto) {
        imageURL = photo.imageURL
    }
}

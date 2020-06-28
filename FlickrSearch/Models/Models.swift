//
//  Models.swift
//  FlickrSearch
//
//  Created by Nivesh on 28/06/20.
//  Copyright © 2020 Nivesh. All rights reserved.
//

import UIKit

// Props Model
struct Photos: Codable {
  let page: Int
  let pages: Int
  let perpage: Int
  let photo: [FlickrPhoto]
  let total: String
}

// Main Model
struct FlickrSearchResults: Codable {
    let stat: String?
    let photos: Photos?
}

// Photo Model
struct FlickrPhoto: Codable {
    
    let farm : Int
    let id : String
    
    let isfamily : Int
    let isfriend : Int
    let ispublic : Int
    
    let owner: String
    let secret : String
    let server : String
    let title: String
    
    var imageURL: String {
        let urlString = String(format: FlickrConstants.imageURL, farm, server, id, secret)
        return urlString
    }
}


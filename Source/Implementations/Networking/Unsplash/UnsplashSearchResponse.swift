//
//  UnsplashSearchResponse.swift
//  Places
//
//  Created by Christian Ampe on 5/16/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

struct UnsplashSearchResponse: Decodable {
    let results: [UnsplashSearchResponseResult]
}

struct UnsplashSearchResponseResult: Decodable {
    let urls: UnsplashSearchResponseImageDictionary
}

struct UnsplashSearchResponseImageDictionary: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

//
//  NSPParksResponse.swift
//  Places
//
//  Created by Christian Ampe on 5/16/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

struct NPSParksReponse: Decodable {
    let data: [NPSPark]
}

struct NPSPark: Decodable {
    let name: String
    let latLong: String
    let images: [NPSParkImage]
}

struct NPSParkImage: Decodable {
    let url: String
}

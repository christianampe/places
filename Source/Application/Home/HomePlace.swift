//
//  HomePlace.swift
//  Places
//
//  Created by Christian Ampe on 5/12/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

struct HomePlace: UIMapViewPlace, UINestedCollectionViewRowCellViewModelProtocol, Codable, Hashable {
    
    // MARK: Map View Properties
    let id: String
    let latitude: Double
    let longitude: Double
    
    // MARK: Collection View Properties
    let name: String
    let detail: String
    let backgroundURLString: String
}

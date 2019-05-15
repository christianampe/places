//
//  Place.swift
//  Places
//
//  Created by Christian Ampe on 5/12/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

struct Place: UIMapViewPlace, UINestedCollectionViewRowCellViewModel {
    
    // MARK: Map View Properties
    let id: String
    let latitude: Double
    let longitude: Double
    
    // MARK: Collection View Properties
    let title: String
    let detail: String
    let iconURLString: String
    let backgroundURLString: String
}

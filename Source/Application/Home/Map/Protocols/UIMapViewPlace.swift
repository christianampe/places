//
//  UIMapViewPlace.swift
//  Places
//
//  Created by Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol UIMapViewPlace {
    var id: String { get }
    var latitude: Double { get }
    var longitude: Double { get }
}

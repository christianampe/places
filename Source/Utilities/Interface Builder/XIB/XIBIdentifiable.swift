//
//  XIBIdentifiable.swift
//  Client
//
//  Created by Christian Ampe on 11/12/18.
//  Copyright © 2018 Educrate. All rights reserved.
//

import Foundation

/// A protocol used for identifying views loaded from xibs.
protocol XIBIdentifiable {
    
    /// The identifier used to describe an object referenced from interface builder.
    static var xibIdentifier: String { get }
}

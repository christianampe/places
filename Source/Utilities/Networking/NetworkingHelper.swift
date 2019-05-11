//
//  NetworkingHelper.swift
//  Client
//
//  Created by Christian Ampe on 12/9/18.
//  Copyright © 2018 Educrate. All rights reserved.
//

import Foundation

class NetworkingHelper {
    
    /// Default json decoder to be utilized
    /// for all internally-conformed codables.
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    /// Default json encoder to be utilized
    /// for all internally-conformed codables.
    static let jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        return encoder
    }()
}

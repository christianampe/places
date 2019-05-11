//
//  NetworkingResponse.swift
//  Client
//
//  Created by Christian Ampe on 9/17/18.
//  Copyright © 2018 Educrate. All rights reserved.
//

import Foundation

struct NetworkingResponse {
    
    /// Data returned from the network request.
    let data: Data
    
    /// URL request sent to server.
    let request: URLRequest
    
    /// HTTP url response returned from server.
    let response: HTTPURLResponse
    
    /// Explicit initializer.
    ///
    /// - Parameters:
    ///   - data: The data returned from the network request.
    ///   - request: The url request sent to server.
    ///   - response: The HTTP url response returned from server.
    init(data: Data,
         request: URLRequest,
         response: HTTPURLResponse) {
        
        self.data = data
        self.request = request
        self.response = response
    }
}

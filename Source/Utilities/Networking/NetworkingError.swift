//
//  NetworkingError.swift
//  Client
//
//  Created by Christian Ampe on 11/16/18.
//  Copyright © 2018 Educrate. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    
    /// Returned when no response is returned from the server.
    case unresponsive
    
    /// Returned when the data task returns an error.
    case underlying(Error)
    
    /// Returned when the service gets an unexpected response.
    case responseMapping(NetworkingResponse)
    
    /// Returned when client declared validation fails.
    case statusCode(NetworkingResponse)
}

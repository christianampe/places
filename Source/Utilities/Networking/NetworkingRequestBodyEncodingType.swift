//
//  NetworkingRequestBodyEncodingType.swift
//  Client
//
//  Created by Christian Ampe on 9/4/18.
//  Copyright © 2018 Educrate. All rights reserved.
//

import Foundation

// MARK: - Request Body Encoding Type Enumeration
enum NetworkingRequestBodyEncodingType {
    
    /// JSON encoded request body.
    case jsonEncoded
}

// MARK: - Computed Variables
extension NetworkingRequestBodyEncodingType {
    
    /// Value of the content-type header.
    var contentTypeValue: String {
        switch self {
        case .jsonEncoded:
            return "application/json"
        }
    }
}

// MARK: - Static Storage
extension NetworkingRequestBodyEncodingType {
    
    /// Key for content-type header.
    static let contentTypeKey = "Content-Type"
}

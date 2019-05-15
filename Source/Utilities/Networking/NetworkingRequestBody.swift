//
//  NetworkingRequestBody.swift
//  Client
//
//  Created by Christian Ampe on 9/4/18.
//  Copyright © 2018 Educrate. All rights reserved.
//

import Foundation

// MARK: - Request Body Object Declaration

/// The object responsible for holding the http request body.
struct NetworkingRequestBody {
    
    /// Type of data encoding applied to the data object.
    let encoding: NetworkingRequestBodyEncodingType
    
    /// Encoded data to be passed in the http body.
    let data: Data
    
    /// Explicit initializer.
    ///
    /// - Parameters:
    ///   - encoding: Type of data encoding applied to the data object.
    ///   - data: Information being passed in the http body.
    init(encoding: NetworkingRequestBodyEncodingType,
         data: Data) {
        
        self.encoding = encoding
        self.data = data
    }
}

// MARK: - Helper Initializers
extension NetworkingRequestBody {
    
    /// Extractable optional initializer.
    ///
    /// - Parameter extractable: Object to be passed in the request body.
    init?<E: Encodable>(_ encodable: E) {
        do {
            self.init(encoding: .jsonEncoded,
                      data: try NetworkingHelper.jsonEncoder.encode(encodable))
        } catch {
            return nil
        }
    }
}


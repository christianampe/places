//
//  NetworkingRequestValidation.swift
//  Client
//
//  Created by Christian Ampe on 9/17/18.
//  Copyright © 2018 Educrate. All rights reserved.
//

import Foundation

enum NetworkingRequestValidation {
    
    // Filter case for only 2XX http status codes.
    case successCodes
}

extension NetworkingRequestValidation {
    
    /// Static code ranges.
    var range: ClosedRange<Int> {
        switch self {
        case .successCodes:
            return 200...299
        }
    }
}

//
//  CALayer+Additions.swift
//  Places
//
//  Created by Christian Ampe on 5/12/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

extension CALayer {
    
    /// Rounds any layer.
    func round() {
        cornerRadius = frame.width / 2
        masksToBounds = true
    }
}

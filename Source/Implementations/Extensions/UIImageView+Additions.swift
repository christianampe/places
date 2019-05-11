//
//  UIImageView+Additions.swift
//  Client
//
//  Created by Christian Ampe on 10/13/18.
//  Copyright © 2018 Educrate. All rights reserved.
//

import UIKit.UIImageView

extension UIImageView {
    
    /// Rounds an image view.
    func round() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
}

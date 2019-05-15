//
//  UIRoundImageView.swift
//  Client
//
//  Created by Christian Ampe on 12/14/18.
//  Copyright © 2018 Educrate. All rights reserved.
//

import UIKit

class UIRoundImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        round()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        round()
    }
}

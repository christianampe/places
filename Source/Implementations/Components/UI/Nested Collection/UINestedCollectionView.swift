//
//  UINestedCollectionView.swift
//  Places
//
//  Created by Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

class UINestedCollectionView: XIBView {
    
    /// Encompasing `UITableView` component which contains rows of type `UICollectionView`.
    @IBOutlet private weak var collection: UINestedCollectionViewColumn!
}

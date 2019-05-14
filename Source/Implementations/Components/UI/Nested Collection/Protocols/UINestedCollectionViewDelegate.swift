//
//  UINestedCollectionViewDelegate.swift
//  Places
//
//  Created by Christian Ampe on 5/12/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

protocol UINestedCollectionViewDelegate: class {
    func nestedCollectionView(_ nestedCollectionView: UINestedCollectionView,
                              didRespondToPanGesture sender: UIPanGestureRecognizer)
}

extension UINestedCollectionViewDelegate {
    func nestedCollectionView(_ nestedCollectionView: UINestedCollectionView,
                              didRespondToPanGesture sender: UIPanGestureRecognizer) {}
}

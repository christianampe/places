//
//  UINestedCollectionViewDelegate.swift
//  Places
//
//  Created by Christian Ampe on 5/12/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

protocol UINestedCollectionViewDelegate: class {
    func tableView(_ tableView: UITableView,
                   didRespondToPanGesture sender: UIPanGestureRecognizer)
    
    func tableView(_ tableView: UITableView,
                   didDisplayItemAt indexPath: IndexPath)
}

extension UINestedCollectionViewDelegate {
    func tableView(_ tableView: UITableView,
                   didRespondToPanGesture sender: UIPanGestureRecognizer) {}
    
    func tableView(_ tableView: UITableView,
                   didDisplayItemAt indexPath: IndexPath) {}
}

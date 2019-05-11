//
//  UINestedCollectionViewRowCellViewModelProtocol.swift
//  Places
//
//  Created by Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol UINestedCollectionViewRowCellViewModel {
    var title: String { get }
    var detail: String { get }
    var iconURLString: String { get }
    var backgroundURLString: String { get }
}

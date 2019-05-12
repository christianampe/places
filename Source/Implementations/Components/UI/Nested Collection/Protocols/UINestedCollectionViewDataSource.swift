//
//  UINestedCollectionViewDataSource.swift
//  Places
//
//  Created by Christian Ampe on 5/12/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol UINestedCollectionViewDataSource: class {
    func numberOfRows(in nestedCollectionView: UINestedCollectionView) -> Int
    
    func nestedCollectionView(_ nestedCollectionView: UINestedCollectionView,
                              viewModelsAt row: Int) -> [UINestedCollectionViewRowCellViewModel]
}

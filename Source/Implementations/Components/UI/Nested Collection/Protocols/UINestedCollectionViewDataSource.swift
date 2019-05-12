//
//  UINestedCollectionViewDataSource.swift
//  Places
//
//  Created by Christian Ampe on 5/12/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol UINestedCollectionViewDataSource: class {
    func numberOfSections(in nestedCollectionView: UINestedCollectionView) -> Int
    
    func nestedCollectionView(_ nestedCollectionView: UINestedCollectionView,
                              numberOfItemsInSection section: Int) -> Int
    
    func nestedCollectionView(_ nestedCollectionView: UINestedCollectionView,
                              viewModelForItemAt indexPath: IndexPath) -> UINestedCollectionViewRowCellViewModel
}

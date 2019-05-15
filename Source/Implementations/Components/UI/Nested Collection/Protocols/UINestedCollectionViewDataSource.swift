//
//  UINestedCollectionViewDataSource.swift
//  Places
//
//  Created by Christian Ampe on 5/12/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

protocol UINestedCollectionViewDataSource: class {
    func numberOfRows(in tableView: UITableView) -> Int
    
    func tableView(_ tableView: UITableView,
                   viewModelsFor row: Int) -> [UINestedCollectionViewRowCellViewModel]
}

//
//  UINestedCollectionViewColumn.swift
//  Places
//
//  Created by Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

class UINestedCollectionViewColumn: UITableView {
    
}

extension UINestedCollectionViewColumn: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        
//        guard let cell =  cell as? UINestedCollectionViewColumnCell else {
//            assertionFailure("incorrect cell type used")
//            return
//        }
    }
}

extension UINestedCollectionViewColumn: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(for: indexPath) as UINestedCollectionViewColumnCell
    }
}


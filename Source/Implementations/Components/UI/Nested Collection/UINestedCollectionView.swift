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
    
    private weak var delegate: UINestedCollectionViewDelegate?
    private weak var dataSource: UINestedCollectionViewDataSource?
}

// MARK: - Lifecycle
extension UINestedCollectionView {
    override func awakeFromNib() {
        super.awakeFromNib()
        collection.dataSource = self
        collection.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension UINestedCollectionView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.numberOfSections(in: self) ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(for: indexPath) as UINestedCollectionViewColumnCell
    }
}

// MARK: - UITableViewDelegate
extension UINestedCollectionView: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        
        guard let cell =  cell as? UINestedCollectionViewColumnCell else {
            assertionFailure("incorrect cell type used")
            return
        }
        
        
    }
}

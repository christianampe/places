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
    @IBOutlet private weak var collection: UITableView!
    
    weak var delegate: UINestedCollectionViewDelegate?
    weak var dataSource: UINestedCollectionViewDataSource?
}

// MARK: - Static Properties
extension UINestedCollectionView {
    static let cellHeight: CGFloat = UINestedCollectionView.rowHeight + UINestedCollectionView.headerHeight
    private static let rowHeight: CGFloat = UIScreen.main.bounds.height * 0.2
    private static let headerHeight: CGFloat = UIScreen.main.bounds.height * 0.05
}

// MARK: - Lifecycle
extension UINestedCollectionView {
    override func awakeFromNib() {
        super.awakeFromNib()
        collection.registerTableViewCell(xibCell: UINestedCollectionViewColumnCell.self)
        collection.dataSource = self
        collection.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension UINestedCollectionView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.numberOfRows(in: self) ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(for: indexPath) as UINestedCollectionViewColumnCell
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        
        return "Popular"
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        
        return UINestedCollectionView.headerHeight
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UINestedCollectionView.rowHeight
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
        
        guard let viewModels = dataSource?.nestedCollectionView(self, viewModelsAt: indexPath.row) else {
            return
        }
        
        cell.set(properties: viewModels)
    }
}

//
//  UINestedCollectionViewColumnCell.swift
//  Places
//
//  Created by Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

class UINestedCollectionViewColumnCell: UITableViewCell {
    
    /// A `UICollectionView` which contains the individual objects to display.
    @IBOutlet private weak var collection: UICollectionView! {
        didSet {
            setUp()
        }
    }
    
    /// The view models used to populate the `UICollectionView`.
    private var viewModels = [UINestedCollectionViewRowCellViewModel]()
}

// MARK: - External API
extension UINestedCollectionViewColumnCell {
    
    /// Method used to populate the collection view with given properties.
    ///
    /// - Parameter newViewModels: The view models used to populate the `UICollectionView`.
    func set(properties newViewModels: [UINestedCollectionViewRowCellViewModel]) {
        viewModels = newViewModels
    }
}

// MARK: - Helper Methods
private extension UINestedCollectionViewColumnCell {
    func setUp() {
        collection.dataSource = self
        collection.delegate = self
        collection.decelerationRate = .fast
    }
}

// MARK: - UICollectionViewDataSource
extension UINestedCollectionViewColumnCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath) as UINestedCollectionViewRowCell
        
        guard let viewModel = viewModels[safe: indexPath.row] else {
            return cell
        }
        
        cell.set(properties: viewModel)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension UINestedCollectionViewColumnCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UINestedCollectionViewColumnCell.itemWidth,
                      height: collectionView.layer.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return UINestedCollectionViewColumnCell.itemSpacing
    }
}

// MARK: - Static Properties
extension UINestedCollectionViewColumnCell {
    static let itemWidth: CGFloat = UIScreen.main.bounds.width * 0.7
    static let itemSpacing: CGFloat = UIScreen.main.bounds.width * 0.05
}

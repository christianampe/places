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
    @IBOutlet private weak var collection: UICollectionView!
    
    /// The view models used to populate the `UICollectionView`.
    private var viewModels = [UINestedCollectionViewRowCellViewModel]()
}

// MARK: - Static Properties
private extension UINestedCollectionViewColumnCell {
    static let itemWidth: CGFloat = UIScreen.main.bounds.width * 0.7
    static let itemSpacing: CGFloat = UIScreen.main.bounds.width * 0.05
}

// MARK: - External API
extension UINestedCollectionViewColumnCell {
    
    /// Method used to populate the collection view with given properties.
    ///
    /// - Parameter newViewModels: The view models used to populate the `UICollectionView`.
    func set(properties newViewModels: [UINestedCollectionViewRowCellViewModel]) {
        viewModels = newViewModels
        collection.reloadData()
    }
}

// MARK: - Lifecycle
extension UINestedCollectionViewColumnCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        collection.registerCollectionViewCell(xibCell: UINestedCollectionViewRowCell.self)
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
        
        return collectionView.dequeueReusableCell(for: indexPath) as UINestedCollectionViewRowCell
    }
}

// MARK: - UICollectionViewDelegate
extension UINestedCollectionViewColumnCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        guard let cell = cell as? UINestedCollectionViewRowCell else {
            assertionFailure("incorrect cell type used")
            return
        }
        
        guard let viewModel = viewModels[safe: indexPath.row] else {
            return
        }
        
        cell.set(properties: viewModel)
    }
}

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

final class SnapCollectionViewLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        let parent = super.targetContentOffset(forProposedContentOffset: proposedContentOffset,
                                               withScrollingVelocity: velocity)
        
        guard let collectionView = collectionView else {
            return parent
        }
        
        let itemSpace = UINestedCollectionViewColumnCell.itemWidth + UINestedCollectionViewColumnCell.itemSpacing
        let horizontalVelocity = velocity.x
        
        var itemIndex = round(collectionView.contentOffset.x / itemSpace)
        
        if horizontalVelocity > 0 {
            itemIndex += 1
        } else if horizontalVelocity < 0 {
            itemIndex -= 1
        }
        
        return CGPoint(x: itemIndex * itemSpace,
                       y: parent.y)
    }
}

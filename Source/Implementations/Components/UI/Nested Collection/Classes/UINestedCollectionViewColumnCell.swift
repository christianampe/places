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
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        guard let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout else {
            assertionFailure("collection view must use flow layout")
            return
        }
        
        let bounds = scrollView.bounds
        let xTarget = targetContentOffset.pointee.x
        let xMax = scrollView.contentSize.width - scrollView.bounds.width
        
        if abs(velocity.x) <= snapToMostVisibleColumnVelocityThreshold {
            let xCenter = scrollView.bounds.midX
            let poses = layout.layoutAttributesForElements(in: bounds) ?? []
            let x = poses.min(by: { abs($0.center.x - xCenter) < abs($1.center.x - xCenter) })?.frame.origin.x ?? 0
            
            targetContentOffset.pointee.x = x
        } else if velocity.x > 0 {
            let poses = layout.layoutAttributesForElements(in: CGRect(x: xTarget,
                                                                      y: 0,
                                                                      width: bounds.size.width,
                                                                      height: bounds.size.height)) ?? []
            
            let xCurrent = scrollView.contentOffset.x
            let x = poses.filter({ $0.frame.origin.x > xCurrent}).min(by: { $0.center.x < $1.center.x })?.frame.origin.x ?? xMax
            
            targetContentOffset.pointee.x = min(x, xMax)
        } else {
            let poses = layout.layoutAttributesForElements(in: CGRect(x: xTarget - bounds.size.width,
                                                                      y: 0,
                                                                      width: bounds.size.width,
                                                                      height: bounds.size.height)) ?? []
            
            let x = poses.max(by: { $0.center.x < $1.center.x })?.frame.origin.x ?? 0
            
            targetContentOffset.pointee.x = max(x, 0)
        }
    }
    
    private var snapToMostVisibleColumnVelocityThreshold: CGFloat { return 0.3 }
}

extension UINestedCollectionViewColumnCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width * 0.7,
                      height: collectionView.layer.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return UIScreen.main.bounds.width * 0.05
    }
}

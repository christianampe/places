//
//  UINestedCollectionViewLayout.swift
//  Places
//
//  Created by Christian Ampe on 5/13/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

protocol UICollectionSnappingFlowLayoutDelegate: class {
    func layout(_ collectionViewLayout: UICollectionViewLayout,
                didSnapToItemAt index: Int)
}

class UINestedCollectionViewLayout: UICollectionViewFlowLayout {
    weak var delegate: UICollectionSnappingFlowLayoutDelegate?
}

// MARK: - Overrides
extension UINestedCollectionViewLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset,
                                             withScrollingVelocity: velocity)
        }
        
        let itemSpace = UINestedCollectionViewColumnCell.itemWidth + UINestedCollectionViewColumnCell.itemSpacing
        let horizontalVelocity = velocity.x
        
        var itemIndex = round(collectionView.contentOffset.x / itemSpace)
        
        if horizontalVelocity > 0 {
            itemIndex += 1
        } else if horizontalVelocity < 0 {
            itemIndex -= 1
        }
        
        delegate?.layout(self, didSnapToItemAt: Int(itemIndex))
        
        return CGPoint(x: itemIndex * itemSpace - UINestedCollectionViewColumnCell.leftInsetSpacing,
                       y: 0)
    }
}

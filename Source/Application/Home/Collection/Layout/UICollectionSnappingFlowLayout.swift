//
//  UICollectionSnappingFlowLayout.swift
//  Places
//
//  Created by Christian Ampe on 5/13/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

class UICollectionSnappingFlowLayout: UICollectionViewFlowLayout {
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

//
//  UINestedCollectionViewColumnCell.swift
//  Places
//
//  Created by Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

protocol UINestedCollectionViewColumnCellDelegate: class {
    func collectionView(_ collectionView: UICollectionView,
                        didDisplayCellAt index: Int)
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt index: Int)
}

extension UINestedCollectionViewColumnCellDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didDisplayCellAt index: Int) {}
}

class UINestedCollectionViewColumnCell: UITableViewCell {
    
    /// A `UICollectionView` which contains the individual objects to display.
    @IBOutlet private weak var collection: UICollectionView!
    
    /// The view models used to populate the `UICollectionView`.
    private var viewModels = [UINestedCollectionViewRowCellViewModel]()
    
    /// The currently focused item index.
    var currentItemIndex: Int  = 0
    
    /// Collection view delegation.
    weak var delegate: UINestedCollectionViewColumnCellDelegate?
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
    
    func focus(index: Int) {
        let requestedCollectionViewIndexPath = IndexPath(row: index, section: 0)
        collection.scrollToItem(at: requestedCollectionViewIndexPath, at: .left, animated: true)
    }
}

// MARK: - Lifecycle
extension UINestedCollectionViewColumnCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        collection.decelerationRate = .fast
        collection.contentInset.left = UINestedCollectionViewColumnCell.leftInsetSpacing
        collection.contentInset.right = UINestedCollectionViewColumnCell.rightInsetSpacing
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

// MARK: - UICollectionViewDelegate
extension UINestedCollectionViewColumnCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        guard indexPath.section == 0 else {
            assertionFailure("collections should only have one section")
            return
        }
        
        delegate?.collectionView(collection,
                                 didSelectItemAt: indexPath.item)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        targetContentOffset.pointee.x = nextFocus(for: scrollView, withVelocity: velocity).offset
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentItemIndex = nextFocus(for: scrollView).index
        
        delegate?.collectionView(collection,
                                 didDisplayCellAt: currentItemIndex)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        currentItemIndex = nextFocus(for: scrollView).index
        
        delegate?.collectionView(collection,
                                 didDisplayCellAt: currentItemIndex)
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

// MARK: - Helper Methods
private extension UINestedCollectionViewColumnCell {
    func nextFocus(for scrollView: UIScrollView,
                           withVelocity velocity: CGPoint = .zero) -> (index: Int, offset: CGFloat) {
        
        let horizontalVelocity = velocity.x
        let itemSpace = UINestedCollectionViewColumnCell.itemWidth + UINestedCollectionViewColumnCell.itemSpacing
        
        var itemIndex = round(scrollView.contentOffset.x / itemSpace)
        
        if horizontalVelocity > 0 {
            itemIndex += 1
        } else if horizontalVelocity < 0 {
            itemIndex -= 1
        }
        
        return (index: correctedIndex(for: Int(itemIndex)),
                offset: itemIndex * itemSpace - UINestedCollectionViewColumnCell.leftInsetSpacing)
    }
    
    func correctedIndex(for index: Int) -> Int {
        guard viewModels.count > 0 else {
            assertionFailure("how did you get this far")
            return 0
        }
        
        guard index > 0 else {
            return 0
        }
        
        let maxRowIndex = max(viewModels.count - 1, 0)
        
        guard index < maxRowIndex else {
            return maxRowIndex
        }
        
        return index
    }
}

// MARK: - Static Properties
extension UINestedCollectionViewColumnCell {
    static let itemWidth: CGFloat = UIScreen.main.bounds.width * 0.75
    static let itemSpacing: CGFloat = UIScreen.main.bounds.width * 0.05
    static let leftInsetSpacing: CGFloat = UINestedCollectionViewColumnCell.itemSpacing
    static let rightInsetSpacing: CGFloat = UIScreen.main.bounds.width - itemWidth - itemSpacing
}

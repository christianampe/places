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
}

extension UINestedCollectionViewColumnCellDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didDisplayCellAt index: Int) {}
}

class UINestedCollectionViewColumnCell: UITableViewCell {
    
    /// A `UICollectionView` which contains the individual objects to display.
    @IBOutlet private weak var collection: UICollectionView!
    @IBOutlet private weak var layout: UICollectionSnappingFlowLayout!
    
    /// The view models used to populate the `UICollectionView`.
    private var viewModels = [UINestedCollectionViewRowCellViewModel]()
    
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
    }
}

// MARK: - Lifecycle
extension UINestedCollectionViewColumnCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        layout.delegate = self
        collection.decelerationRate = .fast
        collection.contentInset.right = UINestedCollectionViewColumnCell.rightInset
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

extension UINestedCollectionViewColumnCell: UICollectionSnappingFlowLayoutDelegate {
    func layout(_ collectionViewLayout: UICollectionViewLayout,
                didSnapToItemAt index: Int) {
        
        delegate?.collectionView(collection,
                                 didDisplayCellAt: index)
    }
}

// MARK: - Static Properties
extension UINestedCollectionViewColumnCell {
    static let itemWidth: CGFloat = UIScreen.main.bounds.width * 0.8
    static let itemSpacing: CGFloat = UIScreen.main.bounds.width * 0.05
    static let rightInset: CGFloat = UIScreen.main.bounds.width - itemWidth - itemSpacing
}

//
//  UINestedCollectionViewRowCell.swift
//  Places
//
//  Created by Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

class UINestedCollectionViewRowCell: UICollectionViewCell {
    
    /// The `UILabel` controlling the main text of this cell.
    @IBOutlet private weak var title: UILabel!
    
    /// The `UILabel` controlling the detail text of this cell.
    @IBOutlet private weak var detail: UILabel!
    
    /// The rounded `UIImageView` controlling the icon of this cell.
    @IBOutlet private weak var icon: UIRoundImageView!
    
    /// The `UImageView` filling the entire background of this cell.
    @IBOutlet private weak var background: UIImageView!
    
    // MARK: Constraints
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    @IBOutlet weak var contentWidth: NSLayoutConstraint!
    @IBOutlet weak var contentLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var contentBottomSpace: NSLayoutConstraint!
}

// MARK: - External API
extension UINestedCollectionViewRowCell {
    
    /// Method used to populate the cell with given properties.
    ///
    /// - Parameter viewModel: The view model used to populate the UI elements.
    func set(properties viewModel: UINestedCollectionViewRowCellViewModelProtocol) {
        title.text = viewModel.name
        detail.text = viewModel.detail
    }
}

// MARK: - Lifecycle
extension UINestedCollectionViewRowCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        styleCell()
        setContentConstraints()
    }
}

private extension UINestedCollectionViewRowCell {
    func styleCell() {
        layer.cornerRadius = 5
    }
    
    func setContentConstraints() {
        let cellHeight = layer.bounds.size.height
        let cellWidth = layer.bounds.size.width
        
        contentHeight.constant = cellHeight * 0.4
        contentWidth.constant = cellWidth * 0.8
        contentLeadingSpace.constant = cellHeight * 0.1
        contentBottomSpace.constant = cellHeight * 0.1
    }
}

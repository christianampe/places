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
}

// MARK: - External API
extension UINestedCollectionViewRowCell {
    
    /// Method used to populate the cell with given properties.
    ///
    /// - Parameter viewModel: The view model used to populate the UI elements.
    func set(properties viewModel: UINestedCollectionViewRowCellViewModel) {
        title.text = viewModel.title
        detail.text = viewModel.detail
    }
}

// MARK: - Lifecycle
extension UINestedCollectionViewRowCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }
}

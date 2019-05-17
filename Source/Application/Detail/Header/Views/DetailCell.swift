//
//  DetailCell.swift
//  Places
//
//  Created by Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class DetailCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    
    private var viewModel: DetailViewCellViewModelProtocol?
}

// MARK: - Public API
extension DetailCell {
    func set(properties newViewModel: DetailViewCellViewModelProtocol) {
        viewModel = newViewModel
        
        guard let imageURL = URL(string: newViewModel.imageURLString) else {
            return
        }
        
        imageView.kf.setImage(with: imageURL)
    }
}


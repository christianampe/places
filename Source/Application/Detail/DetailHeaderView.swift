//
//  DetailHeaderView.swift
//  Places
//
//  Created by Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class DetailHeaderView: UICollectionReusableView {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var directionsButton: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel!
}

// MARK: - UICollectionViewDataSource
extension DetailHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return collectionView.dequeueReusableCell(for: indexPath) as DetailHeaderViewCell
    }
}

// MARK: - UICollectionViewDelegate
extension DetailHeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        
    }
}

extension DetailHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.bounds.size
    }
}

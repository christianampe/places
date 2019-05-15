//
//  DetailViewController.swift
//  Places
//
//  Created Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController, DetailViewProtocol {
    var presenter: DetailPresenterProtocol?
    
    @IBOutlet private weak var collectionView: UICollectionView!
}

// MARK: - UICollectionViewDataSource
extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        return collectionView.dequeueReusableSupplementaryView(for: indexPath) as DetailHeaderView
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return collectionView.dequeueReusableCell(for: indexPath) as DetailCell
    }
}

// MARK: - UICollectionViewDelegate
extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionWidth = collectionView.bounds.size.width
        let nonSpaceWidth = collectionWidth - 2
        let itemSideLength = nonSpaceWidth / 3
        
        return CGSize(width: itemSideLength, height: itemSideLength)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1
    }
}

// MARK: - Static Properties
extension DetailViewController {
    static let imageCollectionHeight: CGFloat = 400
    static let directionButtonHeight: CGFloat = 72
    static let topTextPadding: CGFloat = 48
    static let bottomTextPadding: CGFloat = 48
}

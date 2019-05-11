//
//  UINestedCollectionViewRow.swift
//  Places
//
//  Created by Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

class UINestedCollectionViewRow: UICollectionView {
    
}

extension UINestedCollectionViewRow: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
//        guard let cell = cell as? UINestedCollectionViewRowCell else {
//            assertionFailure("incorrect cell type used")
//            return
//        }
    }
}

extension UINestedCollectionViewRow: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return collectionView.dequeueReusableCell(for: indexPath) as UINestedCollectionViewRowCell
    }
}

//
//  DetailViewController.swift
//  Places
//
//  Created Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController, DetailViewProtocol {
    var input: DetailInputProtocol?
    var output: DetailOutputProtocol?
    var viewModel: DetailViewModelProtocol?
    var presenter: DetailPresenterProtocol?
    
    @IBOutlet private weak var collectionView: UICollectionView!
}

// MARK: - DetailViewProtocol
extension DetailViewController {
    func show(place: DetailViewModel) {
        viewModel = place
        collectionView.reloadData()
    }
    
    func show(error: Error) {
        
    }
}

// MARK: - Lifecycle
extension DetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        presenter?.request(place: "1")
    }
}

// MARK: - Setup Methods
private extension DetailViewController {
    func setUpCollectionView() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            assertionFailure("flow layout must be used for this collection")
            return
        }
        
        let collectionWidth = collectionView.bounds.size.width
        let itemsInRow = DetailViewController.numberOfCellsPerRow
        let nonSpaceWidth = collectionWidth - ((itemsInRow - 1) * DetailViewController.interitemSpacing)
        let itemSideLength = nonSpaceWidth / itemsInRow
        
        layout.minimumLineSpacing = DetailViewController.lineSpacing
        layout.minimumInteritemSpacing = DetailViewController.interitemSpacing
        layout.itemSize = CGSize(width: itemSideLength, height: itemSideLength)
    }
}

// MARK: - UICollectionViewDataSource
extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return viewModel?.collectionCellViewModels?.count ?? 0
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
                        willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String,
                        at indexPath: IndexPath) {
        
        guard let header = view as? DetailHeaderView else {
            assertionFailure("incorrect cell type used")
            return
        }
        
        guard let headerViewModel = viewModel?.headerViewModel else {
            return
        }
        
        header.set(properties: headerViewModel)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        guard let cell = cell as? DetailCell else {
            assertionFailure("incorrect cell type used")
            return
        }
        
        guard let cellViewModel = viewModel?.collectionCellViewModels?[safe: indexPath.item] else {
            return
        }
        
        cell.set(properties: cellViewModel)
    }
}

// MARK: - Static Properties
extension DetailViewController {
    static let imageCollectionHeight: CGFloat = 400
    static let directionButtonHeight: CGFloat = 72
    static let topTextPadding: CGFloat = 48
    static let bottomTextPadding: CGFloat = 48
    static let lineSpacing: CGFloat = 1
    static let interitemSpacing: CGFloat = 1
    static let numberOfCellsPerRow: CGFloat = 3
}

//
//  HomeViewController.swift
//  Places
//
//  Created Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol?
    
    @IBOutlet private weak var nestedCollection: UINestedCollectionView!
    @IBOutlet weak var nestedCollectionTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nestedCollectionHeightConstraint: NSLayoutConstraint!
}

// MARK: - Lifecycle
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}

// MARK: - Helper Methods
private extension HomeViewController {
    func setUp() {
        nestedCollectionSetup()
    }
    
    func nestedCollectionSetup() {
        nestedCollection.dataSource = self
        nestedCollection.delegate = self
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let screenHeight = self.view.bounds.height
            let bottomInset = self.view.safeAreaInsets.bottom
            let topInset = self.view.safeAreaInsets.top
            let intialRowPosition = screenHeight - UINestedCollectionView.cellHeight - bottomInset - topInset
            
            self.nestedCollectionHeightConstraint.constant = screenHeight
            self.nestedCollectionTopConstraint.constant = intialRowPosition
        }
    }
}

// MARK: - UINestedCollectionViewDataSource
extension HomeViewController: UINestedCollectionViewDataSource {
    func numberOfRows(in nestedCollectionView: UINestedCollectionView) -> Int {
        return 1
    }
    
    func nestedCollectionView(_ nestedCollectionView: UINestedCollectionView,
                              viewModelsAt row: Int) -> [UINestedCollectionViewRowCellViewModel] {
        
        let homePlaceViewModel = HomePlaceViewModel(title: "Mammoth Mountain",
                                                    detail: "22 mi",
                                                    iconURLString: "",
                                                    backgroundURLString: "")
        
        return [homePlaceViewModel,homePlaceViewModel,homePlaceViewModel,homePlaceViewModel,homePlaceViewModel,homePlaceViewModel,homePlaceViewModel,homePlaceViewModel,homePlaceViewModel]
    }
}

// MARK: - UINestedCollectionViewDelegate
extension HomeViewController: UINestedCollectionViewDelegate {
    
}

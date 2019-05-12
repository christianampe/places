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
}

extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        nestedCollection.dataSource = self
        nestedCollection.delegate = self
    }
}

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

extension HomeViewController: UINestedCollectionViewDelegate {
    
}

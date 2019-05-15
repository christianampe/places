//
//  HomeViewController.swift
//  Places
//
//  Created Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit
import MapKit

final class HomeViewController: UIViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol?
    
    private var mapViewController: UIMapViewController?
    private var nestedCollectionViewController: UINestedCollectionViewController?
    
    @IBOutlet private weak var nestedCollectionHeightConstraint: NSLayoutConstraint!
}

// MARK: - Lifecycle
extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedMap" {
            mapViewController = segue.viewController()
        }
        
        if segue.identifier == "embedNestedCollection" {
            nestedCollectionViewController = segue.viewController()
            nestedCollectionSetup()
        }
    }
}

// MARK: - Helper Methods
private extension HomeViewController {
    func nestedCollectionSetup() {
        nestedCollectionViewController?.dataSource = self
        nestedCollectionViewController?.delegate = self
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.nestedCollectionHeightConstraint.constant = UINestedCollectionViewController.cellHeight
        }
    }
}

// MARK: - UINestedCollectionViewDataSource
extension HomeViewController: UINestedCollectionViewDataSource {
    func numberOfRows(in tableView: UITableView) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView,
                   viewModelsFor row: Int) -> [UINestedCollectionViewRowCellViewModel] {
        
        let homePlaceViewModel = HomePlaceViewModel(title: "Mammoth Mountain",
                                                    detail: "22 mi",
                                                    iconURLString: "",
                                                    backgroundURLString: "")
        
        return [homePlaceViewModel,homePlaceViewModel,homePlaceViewModel,homePlaceViewModel,homePlaceViewModel,homePlaceViewModel,homePlaceViewModel,homePlaceViewModel,homePlaceViewModel]
    }
}

// MARK: - UINestedCollectionViewDelegate
extension HomeViewController: UINestedCollectionViewDelegate {
    func tableView(_ tableView: UITableView,
                   didRespondToPanGesture sender: UIPanGestureRecognizer) {
        
//        let verticalVelocity = sender.velocity(in: tableView).y
//        let verticalTranslation = sender.translation(in: view).y
//        let verticalContentOffset = tableView.contentOffset.y
//
//        guard verticalContentOffset <= 0.0 else {
//            return
//        }
//
//        guard
//            (nestedCollectionTopConstraint.constant <= 0.0 && verticalVelocity > 0) ||
//            (nestedCollectionTopConstraint.constant > 0.0 && verticalVelocity < 0)
//        else {
//            return
//        }
//
//        tableView.frame.origin.y = tableView.frame.origin.y + verticalTranslation
    }
}

private extension HomeViewController {
    func progressAlongAxis(pointOnAxis: CGFloat,
                           axisLength: CGFloat) -> CGFloat {
        
        let movementOnAxis = pointOnAxis / axisLength
        let positiveMovementOnAxis = fmaxf(Float(movementOnAxis), 0.0)
        let positiveMovementOnAxisPercent = fminf(positiveMovementOnAxis, 1.0)
        
        return CGFloat(positiveMovementOnAxisPercent)
    }
}

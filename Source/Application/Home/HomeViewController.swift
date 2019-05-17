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
    var input: HomeInputProtocol?
    var output: HomeOutputProtocol?
    var viewModel: HomeViewModelProtocol?
    var presenter: HomePresenterProtocol?
    
    private var mapViewController: UIMapViewController?
    private var nestedCollectionViewController: UINestedCollectionViewController?
    
    @IBOutlet private weak var nestedCollectionHeightConstraint: NSLayoutConstraint!
}

// MARK: - HomeViewProtocol
extension HomeViewController {
    func show(error: Error) {
        
    }
    
    func show(collection: HomeCollectionRow) {
        viewModel?.panels.append(collection)
        
        nestedCollectionViewController?.reloadData()
        mapViewController?.set(places: collection.places)
    }
}

// MARK: - Lifecycle
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewSetup()
        nestedCollectionSetup()
        presenter?.requestScreen()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedMap" {
            mapViewController = segue.viewController()
        }
        
        if segue.identifier == "embedNestedCollection" {
            nestedCollectionViewController = segue.viewController()
        }
    }
}

// MARK: - Helper Methods
private extension HomeViewController {
    func mapViewSetup() {
        mapViewController?.dataSource = self
        mapViewController?.delegate = self
    }
    
    func nestedCollectionSetup() {
        nestedCollectionViewController?.dataSource = self
        nestedCollectionViewController?.delegate = self
        nestedCollectionHeightConstraint.constant = UINestedCollectionViewController.cellHeight
    }
}

// MARK: - UIMapViewDataSource
extension HomeViewController: UIMapViewDataSource {
    func mapView(_ mapView: MKMapView,
                 placesIn region: MKCoordinateRegion) -> [UIMapViewPlace] {
        
        // TODO: implement when optimization is necessary and an acceptable api is available
        return []
    }
}

// MARK: - UIMapViewDelegate
extension HomeViewController: UIMapViewDelegate {
    func mapView(_ mapView: MKMapView,
                 didSelect place: UIMapViewPlace) {
        
        guard let collection = nestedCollectionViewController, let viewModel = viewModel else {
            return
        }
        
        let currentRowIndex = collection.currentIndexPath.section
        let currentItemIndex = collection.currentIndexPath.row
        
        guard let currentRowViewModels = viewModel.panels[safe: currentRowIndex] else {
            return
        }
        
        let currentRowViewModelIDs = currentRowViewModels.places.map { $0.id }
        
        guard let currentItemID = currentRowViewModelIDs[safe: currentItemIndex], place.id != currentItemID else {
            return
        }
        
        if let firstMatchingItemIndex = currentRowViewModelIDs.firstIndex(of: place.id) {
            nestedCollectionViewController?.focus(indexPath: IndexPath(item: firstMatchingItemIndex,
                                                                       section: currentRowIndex))
        } else {
            var rowIndex: Int = 0
            
            for x in 0..<viewModel.panels.count {
                rowIndex = x
                guard let panel = viewModel.panels[safe: x] else {
                    continue
                }
                
                let panelIDs = panel.places.map { $0.id }
                
                guard let itemIndex = panelIDs.firstIndex(of: place.id) else {
                    continue
                }
                
                nestedCollectionViewController?.focus(indexPath: IndexPath(item: itemIndex,
                                                                           section: rowIndex))
            }
        }
    }
}

// MARK: - UINestedCollectionViewDataSource
extension HomeViewController: UINestedCollectionViewDataSource {
    func numberOfRows(in tableView: UITableView) -> Int {
        return viewModel?.panels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   viewModelsFor row: Int) -> [UINestedCollectionViewRowCellViewModelProtocol] {
        
        return viewModel?.panels[safe: row]?.places ?? []
    }
    
    func tableView(_ tableView: UITableView,
                   titleFor row: Int) -> String {
        
        return viewModel?.panels[safe: row]?.title ?? ""
    }
}

// MARK: - UINestedCollectionViewDelegate
extension HomeViewController: UINestedCollectionViewDelegate {
    func tableView(_ tableView: UITableView,
                   didDisplayItemAt indexPath: IndexPath) {
        
        guard let place = viewModel?.panels[safe: indexPath.section]?.places[safe: indexPath.item] else {
            return
        }
        
        mapViewController?.move(to: place)
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectItemAt indexPath: IndexPath) {
        
        guard let collection = nestedCollectionViewController else {
            return
        }
        
        guard collection.currentIndexPath == indexPath else {
            collection.focus(indexPath: indexPath)
            return
        }
        
        guard let place = viewModel?.panels[safe: indexPath.section]?.places[safe: indexPath.item] else {
            return
        }
        
        presenter?.selectedPlace(id: place.id,
                                 name: place.name)
    }
}

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
    
    func show(places: HomeViewModel) {
        viewModel = places
        
        nestedCollectionViewController?.reloadData()
        mapViewController?.set(places: places.panel.flatMap { $0.places })
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
        
        guard let currentPanelIndex = nestedCollectionViewController?.currentIndexPath.section else {
            return
        }
        
        guard let currentPanel = viewModel?.panel[safe: currentPanelIndex] else {
            return
        }
        
        let currentPanelPlaceIndex = currentPanel.places.map { $0.id }.firstIndex(of: place.id)
        
        guard let placeIndex = currentPanelPlaceIndex else {
            return
        }
            
        nestedCollectionViewController?.focus(indexPath: IndexPath(item: placeIndex, section: currentPanelIndex))
    }
}

// MARK: - UINestedCollectionViewDataSource
extension HomeViewController: UINestedCollectionViewDataSource {
    func numberOfRows(in tableView: UITableView) -> Int {
        return viewModel?.panel.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   viewModelsFor row: Int) -> [UINestedCollectionViewRowCellViewModel] {
        
        return viewModel?.panel[safe: row]?.places ?? []
    }
    
    func tableView(_ tableView: UITableView,
                   titleFor row: Int) -> String {
        
        return viewModel?.panel[safe: row]?.title ?? ""
    }
}

// MARK: - UINestedCollectionViewDelegate
extension HomeViewController: UINestedCollectionViewDelegate {
    func tableView(_ tableView: UITableView,
                   didDisplayItemAt indexPath: IndexPath) {
        
        guard let place = viewModel?.panel[safe: indexPath.section]?.places[safe: indexPath.item] else {
            return
        }
        
        mapViewController?.move(to: place)
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath)
    }
}

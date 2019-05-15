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
    
    var places: [Place] = []
}

// MARK: - Lifecycle
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let yosemite = Place(id: "1", latitude: 37.8651011, longitude: -119.5383294, title: "Yosemite", detail: "12 mi", iconURLString: "", backgroundURLString: "")
        
        let joshuaTree = Place(id: "2", latitude: 34.134728, longitude: -116.313066, title: "Joshua Tree", detail: "20 mi", iconURLString: "", backgroundURLString: "")
        
        let cannonBeach = Place(id: "3", latitude: 45.8917738, longitude: -123.9615274, title: "Cannon Beach ", detail: "140 mi", iconURLString: "", backgroundURLString: "")
        
        set([yosemite, joshuaTree, cannonBeach])
        
        mapViewSetup()
        nestedCollectionSetup()
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

extension HomeViewController {
    func set(_ places: [Place], clearExisting: Bool = false) {
        if clearExisting {
            self.places = places
        } else {
            self.places.append(contentsOf: places)
        }
    }
}

// MARK: - Helper Methods
private extension HomeViewController {
    func mapViewSetup() {
        mapViewController?.dataSource = self
        mapViewController?.delegate = self
        
        mapViewController?.set(places: places)
    }
    
    func nestedCollectionSetup() {
        nestedCollectionViewController?.dataSource = self
        nestedCollectionViewController?.delegate = self
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.nestedCollectionHeightConstraint.constant = UINestedCollectionViewController.cellHeight + self.view.safeAreaInsets.bottom
        }
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
        
        let mapViewIDs = places.map { $0.id }
        
        guard let placeIndex = mapViewIDs.firstIndex(of: place.id) else {
            return
        }
        
        nestedCollectionViewController?.focus(indexPath: IndexPath(item: placeIndex, section: 0))
    }
}

// MARK: - UINestedCollectionViewDataSource
extension HomeViewController: UINestedCollectionViewDataSource {
    func numberOfRows(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   viewModelsFor row: Int) -> [UINestedCollectionViewRowCellViewModel] {
        
        return places
    }
    
    func tableView(_ tableView: UITableView,
                   titleFor row: Int) -> String {
        
        return "Near Me"
    }
}

// MARK: - UINestedCollectionViewDelegate
extension HomeViewController: UINestedCollectionViewDelegate {
    func tableView(_ tableView: UITableView,
                   didDisplayItemAt indexPath: IndexPath) {
        
        guard let place = places[safe: indexPath.item] else {
            return
        }
        
        mapViewController?.move(to: place)
    }
}

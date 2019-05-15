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
    
    var places: [Place] = {
        let yosemite = Place(id: "1", latitude: 37.8651011, longitude: -119.5383294, title: "Yosemite", detail: "12 mi", iconURLString: "", backgroundURLString: "")
        
        let joshuaTree = Place(id: "2", latitude: 34.134728, longitude: -116.313066, title: "Joshua Tree", detail: "20 mi", iconURLString: "", backgroundURLString: "")
        
        return [yosemite, joshuaTree]
    }()
}

// MARK: - Lifecycle
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewController?.set(places: places)
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

extension HomeViewController: UINestedCollectionViewDelegate {
    func tableView(_ tableView: UITableView,
                   didDisplayItemAt indexPath: IndexPath) {
        
        guard let place = places[safe: indexPath.item] else {
            return
        }
        
        mapViewController?.move(to: place)
    }
}

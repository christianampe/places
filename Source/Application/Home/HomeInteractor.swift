//
//  HomeInteractor.swift
//  Places
//
//  Created Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class HomeInteractor: HomeInteractorProtocol {
    weak var presenter: HomePresenterProtocol?
}

extension HomeInteractor {
    func fetchPlaces() {
        let yosemite = Place(id: "1", latitude: 37.8651011, longitude: -119.5383294, title: "Yosemite", detail: "12 mi", iconURLString: "", backgroundURLString: "")
        
        let joshuaTree = Place(id: "2", latitude: 34.134728, longitude: -116.313066, title: "Joshua Tree", detail: "20 mi", iconURLString: "", backgroundURLString: "")
        
        let cannonBeach = Place(id: "3", latitude: 45.8917738, longitude: -123.9615274, title: "Cannon Beach ", detail: "140 mi", iconURLString: "", backgroundURLString: "")
        
        let row = HomeCollectionRow(title: "Near Me", places: [yosemite, joshuaTree, cannonBeach, yosemite, joshuaTree, cannonBeach])
        let row1 = HomeCollectionRow(title: "Favorited", places: [joshuaTree, cannonBeach])
        let row2 = HomeCollectionRow(title: "Popular", places: [yosemite, yosemite, yosemite, yosemite, joshuaTree])
        
        presenter?.fetched(places: HomeViewModel(panel: [row, row1, row2]))
    }
}

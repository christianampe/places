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
    func fetchPlaces(in state: String) {
        NetworkingProvider.fetchNationalParks(in: state) { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    
                    let places = response.data.compactMap { [weak self] park -> HomePlace? in
                        guard let self = self else { return nil }
                        
                        guard let coordinates = self.coordinates(from: park.latLong) else {
                            return nil
                        }
                        
                        return HomePlace(id: park.id,
                                         latitude: coordinates.lat,
                                         longitude: coordinates.lon,
                                         name: park.name,
                                         detail: "",
                                         backgroundURLString: park.images.first?.url ?? "")
                    }
                    
                    let homeCollectionRow = HomeCollectionRow(title: state,
                                                              places: places)
                    
                    self.presenter?.fetched(collection: homeCollectionRow)
                case .failure(let error):
                    self.presenter?.encountered(error: error)
                }
            }
        }
    }
}

// MARK: - Helper Methods
private extension HomeInteractor {
    func coordinates(from string: String) -> (lat: Double, lon: Double)? {
        let latRegex = "lat:[-+]?[0-9]*[.,]?[0-9]+"
        let longRegex = "long:[-+]?[0-9]*[.,]?[0-9]+"
        
        guard
            let latRange = string.range(of: latRegex, options: .regularExpression),
            let lonRange = string.range(of: longRegex, options: .regularExpression)
        else {
                return nil
        }
        
        let latString = string[latRange].dropFirst(4)
        let lonString = string[lonRange].dropFirst(5)
        
        guard let lat = Double(latString), let lon = Double(lonString) else {
            return nil
        }
        
        return (lat: lat,
                lon: lon)
    }
}

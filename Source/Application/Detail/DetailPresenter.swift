//
//  DetailPresenter.swift
//  Places
//
//  Created Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class DetailPresenter: DetailPresenterProtocol {
    var interactor: DetailInteractorProtocol?
    var router: DetailRouterProtocol?
    weak var view: DetailViewProtocol?
    weak var delegate: DetailDelegateProtocol?
}

extension DetailPresenter {
    func request(place placeID: String) {
        interactor?.fetch(place: placeID)
    }
    
    func fetched(place: DetailViewModel) {
        view?.show(place: place)
    }
    
    func encountered(error: Error) {
        
    }
    
    func getDirections() {
        
    }
}

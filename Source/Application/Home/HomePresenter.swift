//
//  HomePresenter.swift
//  Places
//
//  Created Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class HomePresenter: HomePresenterProtocol {
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    weak var view: HomeViewProtocol?
}

extension HomePresenter {
    func requestScreen() {
        interactor?.fetchPlaces(in: "CA")
        interactor?.fetchPlaces(in: "OR")
    }
}

extension HomePresenter {
    func fetched(collection: HomeCollectionRow) {
        view?.show(collection: collection)
    }
    
    func encountered(error: Error) {
        view?.show(error: error)
    }
}

extension HomePresenter {
    func selectedPlace(id: String,
                       name: String) {
        
        router?.showDetail(DetailInput(placeID: id,
                                       placeName: name))
    }
}

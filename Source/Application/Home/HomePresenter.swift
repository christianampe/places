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
    weak var delegate: HomeDelegateProtocol?
}

extension HomePresenter {
    func requestScreen() {
        interactor?.fetchPlaces(in: "CA")
    }
}

extension HomePresenter {
    func fetched(places: HomeViewModel) {
        view?.show(places: places)
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

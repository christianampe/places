//
//  DetailInteractor.swift
//  Places
//
//  Created Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class DetailInteractor: DetailInteractorProtocol {
    weak var presenter: DetailPresenterProtocol?
}

extension DetailInteractor {
    func fetch(place placeID: String) {
        
        presenter?.fetched(place: DetailViewModel())
    }
}

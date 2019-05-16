//
//  DetailViewModel.swift
//  Places
//
//  Created Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

struct DetailViewModel: DetailViewModelProtocol {
    var headerViewModel: DetailHeaderViewModelProtocol?
    var coordinates: (latitude: Double, longitude: Double)?
    var description: String?
    var collectionCellViewModels: [DetailViewCellViewModelProtocol]?
}

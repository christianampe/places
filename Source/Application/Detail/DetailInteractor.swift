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
        
        let headerShowcaseViewModel = PlaceDetailHeaderShowcaseViewModel(imageURLString: "")
        
        let headerViewModel = PlaceDetailHeaderViewModel(headerCellViewModels: [headerShowcaseViewModel,
                                                                                headerShowcaseViewModel,
                                                                                headerShowcaseViewModel,
                                                                                headerShowcaseViewModel],
                                                         description: "")
        
        let collectionCellViewModel = PlaceDetailCollectionCellViewModel(imageURLString: "")
        
        let viewModel = DetailViewModel(headerViewModel: headerViewModel,
                                        coordinates: nil,
                                        description: nil,
                                        collectionCellViewModels: [collectionCellViewModel,
                                                                   collectionCellViewModel,
                                                                   collectionCellViewModel,
                                                                   collectionCellViewModel,
                                                                   collectionCellViewModel,
                                                                   collectionCellViewModel,
                                                                   collectionCellViewModel,
                                                                   collectionCellViewModel,
                                                                   collectionCellViewModel])
        
        presenter?.fetched(place: viewModel)
    }
}


struct PlaceDetailHeaderViewModel: DetailHeaderViewModelProtocol {
    var headerCellViewModels: [DetailHeaderViewCellViewModelProtocol]?
    var description: String?
}

struct PlaceDetailHeaderShowcaseViewModel: DetailHeaderViewCellViewModelProtocol {
    var imageURLString: String?
}

struct PlaceDetailCollectionCellViewModel: DetailViewCellViewModelProtocol {
    var imageURLString: String?
}

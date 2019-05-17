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
    func fetch(place placeName: String) {
        NetworkingProvider.fetchPhotos(of: placeName) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let imageDictionaries = response.results.map { $0.urls }
                
                let showcaseImageDictionaries = imageDictionaries.dropLast(15)
                let collectionImageDictionaries = imageDictionaries.dropFirst(5)
                
                let showcaseViewModels = showcaseImageDictionaries.map { PlaceDetailHeaderShowcaseViewModel(imageURLString: $0.full) }
                let collectionViewModels = collectionImageDictionaries.map { PlaceDetailCollectionCellViewModel(imageURLString: $0.small) }
                
                let headerViewModel = PlaceDetailHeaderViewModel(headerCellViewModels: showcaseViewModels,
                                                                 description: "")
                
                let viewModel = DetailViewModel(headerViewModel: headerViewModel,
                                                coordinates: nil,
                                                description: nil,
                                                collectionCellViewModels: collectionViewModels)
                
                self.presenter?.fetched(place: viewModel)
            case .failure(let error):
                self.presenter?.encountered(error: error)
            }
        }
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

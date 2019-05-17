//
//  DetailProtocols.swift
//  Places
//
//  Created Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

protocol DetailInputProtocol {
    var placeID: String { get }
    var placeName: String { get }
}

protocol DetailViewModelProtocol {
    var headerViewModel: DetailHeaderViewModelProtocol? { get set }
    var coordinates: (latitude: Double, longitude: Double)? { get set }
    var description: String? { get set }
    var collectionCellViewModels: [DetailViewCellViewModelProtocol]? { get set }
}

protocol DetailOutputProtocol {}

protocol DetailDelegateProtocol: class {
    func detailViewController(_ detailViewController: DetailViewController,
                              didRequestDirectionsToPlace placeID: String)
}

protocol DetailViewProtocol: class {
    var input: DetailInputProtocol? { get set }
    var output: DetailOutputProtocol? { get set }
    var viewModel: DetailViewModelProtocol? { get set }
    var presenter: DetailPresenterProtocol?  { get set }
    var delegate: DetailDelegateProtocol? { get set }
    
    func show(place: DetailViewModel)
    func show(error: Error)
}

protocol DetailPresenterProtocol: class {
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInteractorProtocol? { get set }
    var router: DetailRouterProtocol? { get set }
    
    func request(place placeName: String)
    
    func fetched(place: DetailViewModel)
    func encountered(error: Error)
}

protocol DetailInteractorProtocol: class {
    var presenter: DetailPresenterProtocol?  { get set }
    
    func fetch(place placeName: String)
}

protocol DetailRouterProtocol: class {}

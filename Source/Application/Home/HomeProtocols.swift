//
//  HomeProtocols.swift
//  Places
//
//  Created Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

protocol HomeInputProtocol {}

protocol HomeViewModelProtocol {
    var panels: [HomeCollectionRow] { get set }
}

protocol HomeOutputProtocol {}

protocol HomeDelegateProtocol: class {}

protocol HomeViewProtocol: class {
    var input: HomeInputProtocol? { get set }
    var output: HomeOutputProtocol? { get set }
    var viewModel: HomeViewModelProtocol? { get set }
    var presenter: HomePresenterProtocol?  { get set }
    
    func show(collection: HomeCollectionRow)
    func show(error: Error)
}

protocol HomePresenterProtocol: class {
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    var delegate: HomeDelegateProtocol? { get set }
    
    func requestScreen()
    
    func fetched(collection: HomeCollectionRow)
    func encountered(error: Error)
    
    func selectedPlace(id: String,
                       name: String)
}

protocol HomeInteractorProtocol: class {
    var presenter: HomePresenterProtocol?  { get set }
    
    func fetchPlaces(in state: String)
}

protocol HomeRouterProtocol: class {
    func showDetail(_ input: DetailInput)
}

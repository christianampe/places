//
//  HomeProtocols.swift
//  Places
//
//  Created Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

protocol HomeInputProtocol {}

protocol HomeViewModelProtocol {}

protocol HomeOutputProtocol {}

protocol HomeDelegateProtocol: class {}

protocol HomeViewProtocol: class {
    var presenter: HomePresenterProtocol?  { get set }
}

protocol HomePresenterProtocol: class {
    var interactor: HomeInteractorProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    var view: HomeViewProtocol? { get set }
    var input: HomeInputProtocol? { get set }
    var output: HomeOutputProtocol? { get set }
    var viewModel: HomeViewModelProtocol? { get set }
    var delegate: HomeDelegateProtocol? { get set }
}

protocol HomeInteractorProtocol: class {
    var presenter: HomePresenterProtocol?  { get set }
}

protocol HomeRouterProtocol: class {}

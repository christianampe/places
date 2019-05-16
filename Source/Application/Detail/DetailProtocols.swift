//
//  DetailProtocols.swift
//  Places
//
//  Created Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

protocol DetailInputProtocol {}

protocol DetailViewModelProtocol {}

protocol DetailOutputProtocol {}

protocol DetailDelegateProtocol: class {}

protocol DetailViewProtocol: class {
    var input: DetailInputProtocol? { get set }
    var output: DetailOutputProtocol? { get set }
    var viewModel: DetailViewModelProtocol? { get set }
    var presenter: DetailPresenterProtocol?  { get set }
}

protocol DetailPresenterProtocol: class {
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInteractorProtocol? { get set }
    var router: DetailRouterProtocol? { get set }
    var delegate: DetailDelegateProtocol? { get set }
}

protocol DetailInteractorProtocol: class {
    var presenter: DetailPresenterProtocol?  { get set }
}

protocol DetailRouterProtocol: class {}

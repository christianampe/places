//
//  ProfileProtocols.swift
//  Places
//
//  Created Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

protocol ProfileInputProtocol {}

protocol ProfileViewModelProtocol {}

protocol ProfileOutputProtocol {}

protocol ProfileDelegateProtocol: class {}

protocol ProfileViewProtocol: class {
    var presenter: ProfilePresenterProtocol?  { get set }
}

protocol ProfilePresenterProtocol: class {
    var interactor: ProfileInteractorProtocol? { get set }
    var router: ProfileRouterProtocol? { get set }
    var view: ProfileViewProtocol? { get set }
    var input: ProfileInputProtocol? { get set }
    var output: ProfileOutputProtocol? { get set }
    var viewModel: ProfileViewModelProtocol? { get set }
    var delegate: ProfileDelegateProtocol? { get set }
}

protocol ProfileInteractorProtocol: class {
    var presenter: ProfilePresenterProtocol?  { get set }
}

protocol ProfileRouterProtocol: class {}

//
//  HomeBuilder.swift
//  Places
//
//  Created Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class HomeBuilder {
    static func create(_ delegate: HomeDelegateProtocol?,
                       input: HomeInputProtocol,
                       viewModel: HomeViewModelProtocol = HomeViewModel(),
                       output: HomeOutputProtocol = HomeOutput()) -> UIViewController {
        
        let storyboard = UIStoryboard(storyboard: .home)
        let view: HomeViewController = storyboard.instantiateViewController()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        view.input = input
        view.viewModel = viewModel
        view.output = output
        view.presenter = presenter
        view.delegate = delegate
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}

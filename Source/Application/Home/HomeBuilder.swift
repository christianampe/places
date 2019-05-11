//
//  HomeBuilder.swift
//  Places
//
//  Created Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class HomeBuilder {
    func create(_ delegate: HomeDelegateProtocol?,
                input: HomeInputProtocol,
                viewModel: HomeViewModelProtocol = HomeViewModel(),
                output: HomeOutputProtocol = HomeOutput()) -> UIViewController {
        
        let storyboard = UIStoryboard(storyboard: .home)
        let view: HomeViewController = storyboard.instantiateViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.input = input
        presenter.viewModel = viewModel
        presenter.output = output
        presenter.delegate = delegate
        
        return view
    }
}

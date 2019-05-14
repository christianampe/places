//
//  DetailBuilder.swift
//  Places
//
//  Created Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class DetailBuilder {
    func create(_ delegate: DetailDelegateProtocol?, input: DetailInputProtocol,
                viewModel: DetailViewModelProtocol = DetailViewModel(),
                output: DetailOutputProtocol = DetailOutput()) -> UIViewController {
        
        let storyboard = UIStoryboard(storyboard: .detail)
        let view: DetailViewController = storyboard.instantiateViewController()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        let presenter = DetailPresenter()
        
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

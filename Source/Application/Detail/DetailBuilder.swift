//
//  DetailBuilder.swift
//  Places
//
//  Created Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class DetailBuilder {
    static func create(_ delegate: DetailDelegateProtocol?, input: DetailInputProtocol,
                       viewModel: DetailViewModelProtocol = DetailViewModel(),
                       output: DetailOutputProtocol = DetailOutput()) -> UIViewController {
        
        let storyboard = UIStoryboard(storyboard: .detail)
        let view: DetailViewController = storyboard.instantiateViewController()
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        
        view.presenter = presenter
        view.input = input
        view.viewModel = viewModel
        view.output = output
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.delegate = delegate
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}

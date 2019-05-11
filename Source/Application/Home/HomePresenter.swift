//
//  HomePresenter.swift
//  Places
//
//  Created Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class HomePresenter: HomePresenterProtocol {
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    weak var view: HomeViewProtocol?
    
    var input: HomeInputProtocol?
    var viewModel: HomeViewModelProtocol?
    var output: HomeOutputProtocol?
    weak var delegate: HomeDelegateProtocol?
}

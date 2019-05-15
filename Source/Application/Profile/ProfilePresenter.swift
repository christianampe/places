//
//  ProfilePresenter.swift
//  Places
//
//  Created Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class ProfilePresenter: ProfilePresenterProtocol {
    var interactor: ProfileInteractorProtocol?
    var router: ProfileRouterProtocol?
    weak var view: ProfileViewProtocol?
    
    var input: ProfileInputProtocol?
    var viewModel: ProfileViewModelProtocol?
    var output: ProfileOutputProtocol?
    weak var delegate: ProfileDelegateProtocol?
}

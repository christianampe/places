//
//  HomeRouter.swift
//  Places
//
//  Created Christian Ampe on 5/11/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class HomeRouter: HomeRouterProtocol {
    weak var viewController: UIViewController?
}

extension HomeRouter {
    func showDetail() {
        viewController?.show(DetailBuilder.create(nil,
                                                  input: DetailInput(placeID: "1")),
                             sender: nil)
    }
}

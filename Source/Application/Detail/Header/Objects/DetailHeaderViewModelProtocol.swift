//
//  DetailHeaderViewModelProtocol.swift
//  Places
//
//  Created by Christian Ampe on 5/16/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Foundation

protocol DetailHeaderViewModelProtocol {
    var name: String? { get set }
    var description: String? { get set }
    var headerCellViewModels: [DetailHeaderViewCellViewModelProtocol]? { get set }
}

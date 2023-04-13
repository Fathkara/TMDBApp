//
//  TVListBuilder.swift
//  TMDBApp
//
//  Created by Fatih on 11.04.2023.
//

import Foundation
class TvListBuilder {
    static func make() -> TVListVC {
        let vc = TVListVC()
        let viewModel = TVListViewModel(service: TvListService())
        vc.viewModel = viewModel
        return vc
    }
}

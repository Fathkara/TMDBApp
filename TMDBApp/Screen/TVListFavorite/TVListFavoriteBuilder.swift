//
//  TVListFavoriteBuilder.swift
//  TMDBApp
//
//  Created by Fatih on 15.04.2023.
//

import Foundation
class TvListFavoriteBuilder {
    static func make() -> TVListFavoriteVC {
        let vc = TVListFavoriteVC()
        let viewModel = TvListFavoriteViewModel(coreDataManager: CoreDataManager())
        vc.viewModel = viewModel
        return vc
    }
}

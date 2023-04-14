//
//  TVListDetailBuilder.swift
//  TMDBApp
//
//  Created by Fatih on 14.04.2023.
//

import Foundation
class MovieDetailBuilder {
    static func make(id: Int) -> TVListDetailVC {
        let vc = TVListDetailVC()
        let viewModel = TvDetailViewModel(service: TvListDetailService(), id: id, coreDataMenager: CoreDataManager())
        vc.viewModel = viewModel
        return vc
    }
}

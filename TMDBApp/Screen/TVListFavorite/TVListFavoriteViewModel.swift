//
//  TVListFavoriteViewModel.swift
//  TMDBApp
//
//  Created by Fatih on 15.04.2023.
//

import Foundation
protocol TvListFavoriteViewModelProtocol {
    var output: TvListFavoriteOutput? {get set}
    func deleteCoreData(value: TVShow)
    func fetchCoreData()
}

protocol TvListFavoriteOutput {
    func favoriteTvList(data: [TVShow])
}

class TvListFavoriteViewModel: TvListFavoriteViewModelProtocol {
    var output: TvListFavoriteOutput?
    var coreDataManager: CoreDataManagerProtocol?
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
}

extension TvListFavoriteViewModel {
    func deleteCoreData(value: TVShow) {
        coreDataManager?.deleteTvList(value: value)
    }
    
    func fetchCoreData() {
        let favMovie = coreDataManager?.fetchList()
        output?.favoriteTvList(data: favMovie!)
    }
}

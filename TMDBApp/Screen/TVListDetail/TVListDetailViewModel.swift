//
//  TVListDetailViewModel.swift
//  TMDBApp
//
//  Created by Fatih on 14.04.2023.
//

import Foundation

protocol TvDetailViewModelProtocol {
    var delegate: MovieDetailViewModelDelegate? {get set}
    func loadMovieDetail()
    func addCoreData(data: TvDetail)
}

enum TvDetailOutPut {
    case movieDetailData(data: TvDetail)
    case showError(data: String)
}

protocol MovieDetailViewModelDelegate {
    func handleOutput(output: TvDetailOutPut)
}
class TvDetailViewModel: TvDetailViewModelProtocol {
    var delegate: MovieDetailViewModelDelegate?
    var service: TvListDetailServiceProtocol
    var id: Int?
    var coreDataMenager: CoreDataManagerProtocol?
    
    init(service: TvListDetailServiceProtocol, id: Int, coreDataMenager: CoreDataManagerProtocol) {
        self.service = service
        self.id = id
        self.coreDataMenager = coreDataMenager
    }
}

extension TvDetailViewModel {
    func loadMovieDetail() {
        service.fetchTvShowDetail(id: id!) { [delegate] tvshow in
            delegate?.handleOutput(output: .movieDetailData(data: tvshow))
        } onFailure: { [delegate] error in
            delegate?.handleOutput(output: .showError(data: error))
        }

    }
    
    func addCoreData(data: TvDetail) {
        coreDataMenager?.addMovie(value: data)
    }
}

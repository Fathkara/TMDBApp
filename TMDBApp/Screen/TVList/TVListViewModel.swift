//
//  TVListViewModel.swift
//  TMDBApp
//
//  Created by Fatih on 11.04.2023.
//

import Foundation
protocol TVListViewModelProtocol {
    var delegate: TVListViewModelDelegate? { get set }
    func load()
}
enum TvListViewModelOutPut {
    case tvlist ([Result])
    case error (String)
}
protocol TVListViewModelDelegate {
    func handleOutPut(output:TvListViewModelOutPut)
}
class TVListViewModel:TVListViewModelProtocol {
    var delegate: TVListViewModelDelegate?
    var service: TvListServiceProtocol?
    private var tvList: [Result] = []
    private var page : Int = 1
    init(service: TvListServiceProtocol? = nil) {
        self.service = service
    }
    
    func load() {
        service?.fetchTvShow(page: page, onSuccess: { [delegate] tv in
            self.tvList.append(contentsOf: tv)
            delegate?.handleOutPut(output: .tvlist(self.tvList))
            self.page += 1
        }, onFailure: { [delegate] error in
            delegate?.handleOutPut(output: .error(error))
        })
    }
    
    
    
    
}


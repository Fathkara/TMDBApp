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
    init(service: TvListServiceProtocol? = nil) {
        self.service = service
    }
    
    func load() {
        service?.fetchTvShow(onSuccess: { [delegate] tv in
            delegate?.handleOutPut(output: .tvlist(tv))
        }, onFailure: { [delegate] error in
            delegate?.handleOutPut(output: .error(error))
        })
    }
    
    
    
    
}


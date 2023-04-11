//
//  ViewController.swift
//  TMDBApp
//
//  Created by Fatih on 11.04.2023.
//

import UIKit

class TVListVC: UIViewController, TVListViewModelDelegate {
    
    
    var viewModel: TVListViewModelProtocol?
    var arrTv = [Result]()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        viewModel!.load()
    }
    func handleOutPut(output: TvListViewModelOutPut) {
        switch output {
        case.tvlist(let tvList):
            self.arrTv = tvList
        case.error(let error):
            print(error)
        }
    }


}


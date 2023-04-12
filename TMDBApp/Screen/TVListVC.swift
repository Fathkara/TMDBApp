//
//  ViewController.swift
//  TMDBApp
//
//  Created by Fatih on 11.04.2023.
//

import UIKit
import SnapKit

class TVListVC: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var viewModel: TVListViewModelProtocol?
    var arrTv = [Result]()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        viewModel!.load()
        configure()
    }
    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        Constraints()
    }
    func Constraints() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    


}
extension TVListVC: TVListViewModelDelegate {
    func handleOutPut(output: TvListViewModelOutPut) {
        switch output {
        case.tvlist(let tvList):
            self.arrTv = tvList
        case.error(let error):
            print(error)
        }
    }
}
extension TVListVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}


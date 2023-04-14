//
//  ViewController.swift
//  TMDBApp
//
//  Created by Fatih on 11.04.2023.
//

import UIKit
import SnapKit

class TVListVC: UIViewController {
    
    lazy var tvListTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    lazy var searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        return searchBar
    }()
    
    var viewModel: TVListViewModelProtocol?
    private var tvData = [Result]()
    private var tvList = [Result]()
    private var isSearch =  false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDelegate()
        viewModel!.load()
        
    }
    func initDelegate() {
        viewModel?.delegate = self
        tvListTableView.delegate = self
        tvListTableView.dataSource = self
        searchBar.delegate = self
        configure()
        configureConstraints()
    }
    func configure() {
        view.addSubview(searchBar)
        view.addSubview(tvListTableView)
        searchBar.placeholder = TVListConstant.TVListUIConstant.placeHolder.rawValue
        searchBar.showsCancelButton = true
        tvListTableView.register(TVListCell.self, forCellReuseIdentifier: TVListCell.Identifier.path.rawValue)

    }

    
    @objc func didTapBackButton(){
        dismiss(animated: true)
    }
    


}
extension TVListVC: TVListViewModelDelegate {
    func handleOutPut(output: TvListViewModelOutPut) {
        switch output {
        case.tvlist(let tvList):
            DispatchQueue.main.async {
                self.tvData = tvList
                self.tvListTableView.reloadData()
            }
        case.error(let error):
            print(error)
        }
    }
}
extension TVListVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = Int()
        if isSearch {
            count = tvList.count
        }else{
            count = tvData.count
        }
        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TVListCell.Identifier.path.rawValue) as? TVListCell else
        {
            return UITableViewCell()
        }
        if isSearch {
            cell.saveModel(value: tvList[indexPath.row])
        }else{
            cell.saveModel(value: tvData[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height * 0.09
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var id: Int?
        
        if isSearch {
          id = tvList[indexPath.row].id ?? 0
        }else{
           id = tvData[indexPath.row].id ?? 0
        }
        let vc = TVListDetailBuilder.make(id: id ?? 0)
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension TVListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchBar.text != "" {
            isSearch = true
            tvList = tvData.filter({($0.name!.lowercased().contains(searchText.lowercased()) )})
        }else{
            isSearch = false
        }
        tvListTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text?.removeAll()
        isSearch = false
        self.searchBar.endEditing(true)
        DispatchQueue.main.async {
            self.tvListTableView.reloadData()
        }
    }
}
extension TVListVC {
    func configureConstraints(){
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.width * 0.15)
            make.left.right.equalTo(view)
        }

        tvListTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


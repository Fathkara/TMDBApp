//
//  TVListFavoriteVC.swift
//  TMDBApp
//
//  Created by Fatih on 15.04.2023.
//

import UIKit
import Lottie

class TVListFavoriteVC: UIViewController {
    
    //MARK: UI

   private let generalView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let favTvListTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UIScreen.main.bounds.width * 0.17
        tableView.register(TvListFavoriteCell.self, forCellReuseIdentifier: TvListFavoriteCell.Identifier.path.rawValue)
        return tableView
    }()
    
    private let animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "empty-box-orange-theme")
        animationView.isHidden = true
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }()
    
    //MARK: Properties

    private var favIsEmpty = true
    private var tvList = [TVShow]()
    var viewModel: TvListFavoriteViewModelProtocol?
    private let context = appDelegate.persistentContainer.viewContext
    
    //MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initDelegate()
        configure()
        configureConstraints()
        isEmpty()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isEmpty()
        fetchData()
        favTvListTableView.reloadData()
    }
    
    //MARK: Private Function
    
    private func initDelegate() {
        viewModel?.output = self
        favTvListTableView.delegate = self
        favTvListTableView.dataSource = self
    }

    private func configure(){
        view.backgroundColor = .white
        view.addSubview(generalView)
        view.addSubview(favTvListTableView)
        view.addSubview(animationView)
        navigationItem.hidesBackButton = true
        navigationItem.title = "FAVORITES TV SERIES"
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]
        let leftButton = UIBarButtonItem(image: UIImage(named: "backbutton"), style: .done, target: self, action: #selector(leftButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    private func fetchData(){
        viewModel?.fetchCoreData()
    }
    
    @objc func leftButtonTapped(){
        navigationController?.popViewController(animated: true)
    }

    
    private func isEmpty(){
        if tvList.isEmpty {
            favIsEmpty = true
            favTvListTableView.isHidden = true
            animationView.isHidden = false
        }else{
            favIsEmpty = false
            favTvListTableView.isHidden = false
            animationView.isHidden = true
        }
    }
}

// MARK: MovieFavoriteOutput

extension TVListFavoriteVC: TvListFavoriteOutput {
    func favoriteTvList(data: [TVShow]) {
        self.tvList = data
        self.favTvListTableView.reloadData()
    }
}

//MARK: -Tableview
extension TVListFavoriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TvListFavoriteCell.Identifier.path.rawValue) as? TvListFavoriteCell else
        {
            return UITableViewCell()
        }
        cell.saveUI(movie: tvList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.1
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let alertAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completion) in
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this movie?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                let movie = self.tvList[indexPath.row]
                self.viewModel?.deleteCoreData(value: movie)
                self.favTvListTableView.reloadData()
                self.fetchData()
                self.isEmpty()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [alertAction])
    }
}

//MARK: Constraints
extension TVListFavoriteVC {
    private func configureConstraints(){
        generalView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(0.001 * UIScreen.main.bounds.height)
        }
        favTvListTableView.snp.makeConstraints { make in
            make.top.equalTo(generalView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        animationView.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(view)
            make.height.width.equalTo(UIScreen.main.bounds.width * 0.6)
        }
    }
}

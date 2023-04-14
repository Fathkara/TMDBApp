//
//  TVListDetailVC.swift
//  TMDBApp
//
//  Created by Fatih on 14.04.2023.
//

import UIKit
import CoreData
import AlamofireImage
let appDelegate = UIApplication.shared.delegate as! AppDelegate

class TVListDetailVC: UIViewController {
    
    //MARK: UI
    
    let tvShowGenre = CustomLabel()
    let tvOriginalLanguage = CustomLabel()
    let tvOverview = CustomLabel()
    
    let tvShowImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    //MARK: Properties

    var viewModel: TvDetailViewModelProtocol?
    let context = appDelegate.persistentContainer.viewContext
    var favTvShow: TvDetail? = nil
    
    //MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureConstraints()
        viewModel?.delegate = self
        viewModel?.loadtvShowDetail()
    }
    
    //MARK: Private Function
    
    private func configure(){
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        view.addSubview(tvShowImage)
        view.addSubview(tvOriginalLanguage)
        view.addSubview(tvShowGenre)
        view.addSubview(tvOverview)

        
        let leftButton = UIBarButtonItem(image: UIImage(named: "backbutton"), style: .done, target: self, action: #selector(leftButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        

    }
    
    private func saveUI(tvListData: TvDetail){
        navigationItem.title = tvListData.name
        var genreData = ""
        guard let genre = tvListData.genres else { return }
        for i in genre  {
            genreData +=  "\(i.name!) \n"
        }
        tvShowGenre.labelText(text: "GENRES: \n\(genreData)")
        tvShowGenre.text = "GENRES: \n\(genreData)"
        tvOverview.text = "OVERVIEW: \n \(tvListData.overview!)"
        tvOriginalLanguage.text = "ORIGINAL LANGUAGE: \n \(tvListData.originalLanguage!)"
        
        if let url = URL(string: TvDetailConstant.imageUrl.imageURL(url: tvListData.backdropPath ?? "")) {
            tvShowImage.af.setImage(withURL: url)
        }
    }
    
    @objc func didTapFavButton(){
        if let tvListDetail = favTvShow {
            viewModel?.addCoreData(data: tvListDetail)
        }

    }
    
    @objc func leftButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
}

//MARK: MovieDetailViewModelDelegate

extension TVListDetailVC: MovieDetailViewModelDelegate{
    func handleOutput(output: TvDetailOutPut) {
        switch output {
        case .tvShowDetailData(data: let movie):
            DispatchQueue.main.async {
                self.saveUI(tvListData: movie)
                self.favTvShow = movie
            }
            
        case .showError(data: let error):
            print(error)
        }
    }
}

//MARK: Constraints

extension TVListDetailVC {
    private func configureConstraints(){
        tvShowImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(UIScreen.main.bounds.height * 0.3)
            make.left.right.equalTo(view)
        }
        
        tvShowGenre.snp.makeConstraints { make in
            make.top.equalTo(tvShowImage.snp.bottom).offset(24)
            make.left.equalTo(view).offset(24)
            make.width.equalTo(UIScreen.main.bounds.width * 0.25)
        }
        tvOriginalLanguage.snp.makeConstraints { make in
            make.top.equalTo(tvShowImage.snp.bottom).offset(24)
            make.right.equalTo(view).offset(-24)
            make.width.equalTo(UIScreen.main.bounds.width * 0.5)
        }
        tvOverview.snp.makeConstraints { make in
            make.top.equalTo(tvOriginalLanguage.snp.bottom).offset(24)
            make.left.right.equalTo(view)
        }

    }
}

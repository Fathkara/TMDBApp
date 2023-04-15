//
//  TVListDetailVC.swift
//  TMDBApp
//
//  Created by Fatih on 14.04.2023.
//

import UIKit
import CoreData
import AlamofireImage
import Lottie
let appDelegate = UIApplication.shared.delegate as! AppDelegate

class TVListDetailVC: UIViewController {
    
    //MARK: UI
    
    let tvShowGenre = CustomLabel()
    let tvNumberOfSeasons = CustomLabel()
    let tvOverview = CustomLabel()
    
    let tvShowImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    let addToFav: UIButton = {
        let button = UIButton()
        button.setTitle(TvDetailConstant.UIConstant.favButtonTitle.rawValue, for: .normal)
        button.titleLabel!.font = UIFont(name: "Poppins-SemiBold", size: 15)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        return button
    }()
    let animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "91001-success")
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        return animationView
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
        view.addSubview(tvNumberOfSeasons)
        view.addSubview(tvShowGenre)
        view.addSubview(tvOverview)
        view.addSubview(addToFav)
        view.addSubview(animationView)

        
        let leftButton = UIBarButtonItem(image: UIImage(named: "backbutton"), style: .done, target: self, action: #selector(leftButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        addToFav.addTarget(self, action: #selector(didTapFavButton), for: .touchUpInside)
        

    }
    
    private func saveUI(tvListData: TvDetail){
        navigationItem.title = tvListData.name
        var genreData = ""
        guard let genre = tvListData.genres else { return }
        for i in genre  {
            genreData +=  "\(i.name!) \n"
        }
        var seasonData = ""
        guard let season = tvListData.seasons else {return}
        for k in season {
            seasonData += "\(k.seasonNumber!) \n"
        }
        tvShowGenre.labelText(text: "GENRES: \n\(genreData)")
        tvShowGenre.text = "GENRES: \n\(genreData)"
        tvOverview.text = "OVERVIEW: \n \(tvListData.overview!)"
        tvNumberOfSeasons.text = "TOTAL NUMBER OF SEASONS: \n \(seasonData.count)"
        
        if let url = URL(string: TvDetailConstant.imageUrl.imageURL(url: tvListData.backdropPath ?? "")) {
            tvShowImage.af.setImage(withURL: url)
        }
    }
    
    @objc func didTapFavButton(){
        if let tvListDetail = favTvShow {
            viewModel?.addCoreData(data: tvListDetail)
        }
        animationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
            animationView.stop()
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
        tvNumberOfSeasons.snp.makeConstraints { make in
            make.top.equalTo(tvShowImage.snp.bottom).offset(24)
            make.right.equalTo(view).offset(-24)
            make.width.equalTo(UIScreen.main.bounds.width * 0.5)
        }
        tvOverview.snp.makeConstraints { make in
            make.top.equalTo(tvNumberOfSeasons.snp.bottom).offset(64)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
        addToFav.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.width.equalTo(UIScreen.main.bounds.width * 0.5)
            make.centerX.equalTo(view)
        }
        animationView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view)
            make.height.width.equalTo(UIScreen.main.bounds.width * 0.3)
        }

    }
}

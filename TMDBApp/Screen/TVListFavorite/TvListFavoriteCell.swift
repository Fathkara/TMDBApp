//
//  TvListFavoriteCell.swift
//  TMDBApp
//
//  Created by Fatih on 15.04.2023.
//

import UIKit

class TvListFavoriteCell: UITableViewCell {

    //MARK: UI
    
    let favTvShowImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    let favTvShowName = CustomLabel()

    enum Identifier: String {
           case path = "cell"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Function
    
    func saveUI(movie: TVShow){
        favTvShowName.text = movie.title
        let imageUrl = "https://image.tmdb.org/t/p/w500"
        favTvShowImage.af.setImage(withURL: URL(string: "\(imageUrl)"+"\(movie.image!)")!)
    }
    
    private func configure() {
        contentView.addSubview(favTvShowImage)
        contentView.addSubview(favTvShowName)
        favTvShowName.textAlignment = .left
        
    }

}
//MARK: Constraints

extension TvListFavoriteCell{
    private func configureConstraints(){
        favTvShowImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.bottom.equalTo(contentView.snp.bottom).offset(-15)
            make.left.equalTo(contentView).offset(8)
            make.width.equalTo(contentView.frame.width * 0.2)
        }
        favTvShowName.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(favTvShowImage.snp.right).offset(24)
            make.width.equalToSuperview()
        }
    }
}

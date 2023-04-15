//
//  TVListCell.swift
//  TMDBApp
//
//  Created by Fatih on 13.04.2023.
//

import UIKit
import AlamofireImage
class TVListCell: UITableViewCell {

    //MARK: UI

    let tvName = CustomLabel()
    let tvImage = UIImageView()
    
    enum Identifier: String {
        case path = "Cell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Function
    
    private func configure(){
        contentView.addSubview(tvName)
        contentView.addSubview(tvImage)
        tvName.textAlignment = .left
        tvName.font = UIFont.systemFont(ofSize: 15)
        tvImage.layer.cornerRadius = 5
        tvImage.layer.masksToBounds = true
        tvImage.contentMode = .scaleAspectFill
        
        configureConstraints()
    }
    
    func saveModel(value: Result){
        tvName.text = value.name
        let imageUrl = "https://image.tmdb.org/t/p/w500"
        if let url = URL(string: "\(imageUrl)"+"\(value.posterPath ?? "")") {
            tvImage.af.setImage(withURL: url)
        }
    }

}
extension TVListCell {
    func configureConstraints(){
        tvName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalTo(contentView)
            make.width.equalTo(contentView.bounds.width * 0.9)
            make.height.equalTo(contentView.bounds.height * 0.6)
        }
        
        tvImage.snp.makeConstraints { make in
            make.left.equalTo(tvName.snp.right).offset(-20)
            make.centerY.equalTo(contentView)
            make.width.equalTo(contentView.bounds.width * 0.3)
            make.height.equalTo(contentView.bounds.height * 1.2)
        }
    }
}

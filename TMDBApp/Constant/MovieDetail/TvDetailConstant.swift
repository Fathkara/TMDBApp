//
//  MovieDetail,.swift
//  TMDBApp
//
//  Created by Fatih on 14.04.2023.
//

import Foundation
class TvDetailConstant {
    enum UIConstant: String {
        case favButtonTitle = "Add To Favorites"
    }
    
    enum imageUrl: String {
        case imageURL = "https://image.tmdb.org/t/p/w500"
        
        static func imageURL(url: String) -> String {
            return "\(imageURL.rawValue)\(url)"
        }
    }
}

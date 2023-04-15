//
//  NetworkConstant.swift
//  TMDBApp
//
//  Created by Fatih on 11.04.2023.
//

import Foundation
class NetworkConstant {
    
    enum tvListAPI: String {
        case pathUrl = "https://api.themoviedb.org/3/tv"
        case genreUrl = "/popular"
        case apiKey = "?api_key=7449b8e0901923de98300585d22d2be7"
        case languageUrl = "&language=en-US&page=1"
        
        
        static func tvListAPI(page:Int) -> String {
            let pageUrl = "\(page)"
            return "\(pathUrl.rawValue)\(genreUrl.rawValue)\(apiKey.rawValue)\(languageUrl.rawValue)\(pageUrl)"
        }
    }
    
    enum tvDetailAPI: String {
        case pathUrl = "https://api.themoviedb.org/3/tv/"
        case apiKey = "?api_key=7449b8e0901923de98300585d22d2be7"
        case languageUrl = "&language=en-US"
        
        static func tvDetailAPI(id: Int) -> String {
            return "\(pathUrl.rawValue)\(id)\(apiKey.rawValue)\(languageUrl.rawValue)"
        }
    }
}

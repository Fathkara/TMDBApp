//
//  TVShowListService.swift
//  TMDBApp
//
//  Created by Fatih on 11.04.2023.
//

import Foundation
import UIKit
protocol TvListServiceProtocol {
    func fetchTvShow(page:Int,onSuccess: @escaping ([Result])-> Void, onFailure: @escaping (String) -> Void)
}

class TvListService: TvListServiceProtocol {
    func fetchTvShow(page:Int,onSuccess: @escaping ([Result]) -> Void, onFailure: @escaping (String) -> Void) {
        guard let url = URL(string: NetworkConstant.tvListAPI.tvListAPI(page: page)) else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                onFailure(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                onFailure("No data received")
                return
            }
            
            do {
                print(String(data: data, encoding: .utf8) ?? "")
                let results = try JSONDecoder().decode(TvShow.self, from: data)
                onSuccess(results.results!)
            } catch let error {
                print(error)
                onFailure("Failed to decode data")
            }
        }
        task.resume()
    }
}

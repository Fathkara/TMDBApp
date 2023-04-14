//
//  TvShowDetailService.swift
//  TMDBApp
//
//  Created by Fatih on 14.04.2023.
//

import Foundation
import UIKit
protocol TvListDetailServiceProtocol {
    func fetchTvShowDetail(id:Int,onSuccess: @escaping (TvDetail)-> Void, onFailure: @escaping (String) -> Void)
}

class TvListDetailService: TvListDetailServiceProtocol {
    func fetchTvShowDetail(id:Int,onSuccess: @escaping (TvDetail) -> Void, onFailure: @escaping (String) -> Void) {
        guard let url = URL(string: NetworkConstant.tvDetailAPI.tvDetailAPI(id: id)) else {return}
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
                let results = try JSONDecoder().decode(TvDetail.self, from: data)
                onSuccess(results)
            } catch let error {
                print(error)
                onFailure("Failed to decode data")
            }
        }
        task.resume()
    }
}

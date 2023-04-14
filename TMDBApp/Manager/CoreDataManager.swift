//
//  CoreDataManager.swift
//  TMDBApp
//
//  Created by Fatih on 14.04.2023.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataManagerProtocol {
    func addMovie(value: TvDetail)
    func deleteMovie(value: TVShow)
    func fetchMovie() -> [TVShow]
}

class CoreDataManager: CoreDataManagerProtocol {
    let context = appDelegate.persistentContainer.viewContext
    var tvList: [TVShow] = []
    
    func fetchMovie() -> [TVShow] {
        do{
            tvList = try context.fetch(TVShow.fetchRequest())
        }catch{
            print(error)
        }
        return tvList
    }
    
    func addMovie(value: TvDetail) {
        
        let movieFav = self.fetchMovie()
        var idList: [String] = []
        
        for i in movieFav {
            idList.append(i.id ?? "")
        }
        
        if !(idList.contains(String(value.id ?? 0))) {
            let tvList = TVShow(context: context)
            tvList.title = value.title
            tvList.image = value.backdropPath
            tvList.id = "\(value.id ?? 0)"
            appDelegate.saveContext()
        }
    }
    
    func deleteMovie(value: TVShow) {
        self.context.delete(value)
        appDelegate.saveContext()
    }
}

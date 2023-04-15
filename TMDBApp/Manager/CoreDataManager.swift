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
    func addTvList(value: TvDetail)
    func deleteTvList(value: TVShow)
    func fetchList() -> [TVShow]
}

class CoreDataManager: CoreDataManagerProtocol {
    let context = appDelegate.persistentContainer.viewContext
    var tvList: [TVShow] = []
    
    func fetchList() -> [TVShow] {
        do{
            tvList = try context.fetch(TVShow.fetchRequest())
        }catch{
            print(error)
        }
        return tvList
    }
    
    func addTvList(value: TvDetail) {
        
        let movieFav = self.fetchList()
        var idList: [String] = []
        
        for i in movieFav {
            idList.append(i.id ?? "")
        }
        
        if !(idList.contains(String(value.id ?? 0))) {
            let tvList = TVShow(context: context)
            tvList.title = value.name
            tvList.image = value.backdropPath
            tvList.id = "\(value.id ?? 0)"
            appDelegate.saveContext()
        }
    }
    
    func deleteTvList(value: TVShow) {
        self.context.delete(value)
        appDelegate.saveContext()
    }
}

//
//  DataBaseHandler.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 27/06/22.
//

import Foundation
import CoreData

final class DataBaseHandler {
    private let dataBaseManager = DataBaseManager()
    private let showViewModel = ShowViewModel()
    private var shows = [Show]()
    
    func saveItems() {
        do {
            try dataBaseManager.getContext().save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadItems(completionHandler: @escaping ([Show]) -> ()) {
        let request: NSFetchRequest<Show> = Show.fetchRequest()
        shows = dataBaseManager.fetchData(request: request)
        completionHandler(shows)
    }
    
    func addToFavorites(shows: ShowModel) ->  Bool {
        var currentSelectedShow = shows
        var alreadyFavorite = false
        
        let newFavoriteShow = Show(context: dataBaseManager.getContext())
        newFavoriteShow.score = currentSelectedShow.score
        newFavoriteShow.imageURL = currentSelectedShow.imageURL
        newFavoriteShow.name = currentSelectedShow.name
        newFavoriteShow.isLiked = true
        currentSelectedShow.isLiked = true
        
        if newFavoriteShow.isLiked {
            for show in showViewModel.returnfavoriteShows() {
                if show.name == currentSelectedShow.name {
                    alreadyFavorite = true
                    break
                }
            }
            
            if !alreadyFavorite {
                var favoriteShows = showViewModel.returnfavoriteShows()
                favoriteShows.append(newFavoriteShow)
                showViewModel.updateFavoriteShows(favoriteShows: favoriteShows)
                return true
            }
        }
        return false
    }
}

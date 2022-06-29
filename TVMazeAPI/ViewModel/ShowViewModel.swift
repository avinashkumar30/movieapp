//
//  TVMazeManager.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 13/04/22.
//

import Foundation
import UIKit

final class ShowViewModel {
    private var arr = [ShowModel]()
    private var favoriteShows = [Show]()
    
    func fetchShows(queryParam: String, completionHandler: @escaping ([ShowModel]) -> ()) {
        let urlString = "\(Api.showURL)?q=\(queryParam)"
        performRequest(urlString: urlString) { [weak self] arr in
            completionHandler(self!.arr)
        }
    }
    
    func getShow(indexPath: IndexPath) -> ShowModel {
        return arr[indexPath.row]
    }
    
    func getShow(index: Int) -> ShowModel {
        return arr[index]
    }
    
    func numberOfShows() -> Int {
        return arr.count
    }
    
    func returnfavoriteShows() -> [Show] {
        return favoriteShows
    }
    
    func updateFavoriteShows(favoriteShows: [Show]) {
        self.favoriteShows = favoriteShows
    }
    
    func performRequest(urlString: String, completionHandler: @escaping ([ShowModel]) -> ()) {
        guard let url = URL(string: urlString) else {
            return
        }
    
        let session = URLSession(configuration: .default)
    
        let task = session.dataTask(with: url) { data, response, error in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with:
                                     dataResponse, options: [])
                if let jsonArray = jsonResponse as? [[String: Any]]  {
                    for dic in jsonArray {
                        self.arr.append(ShowModel(dic))
                    }
                    completionHandler(self.arr)
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}

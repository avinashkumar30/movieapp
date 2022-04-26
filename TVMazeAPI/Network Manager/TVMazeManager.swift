//
//  TVMazeManager.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 13/04/22.
//

import Foundation
import UIKit

class TVMazeManager {
    let showURL = "https://api.tvmaze.com/search/shows"
    var arr = [ShowDetails]()
    var favoriteShows = [Show]()
    
    func fetchShows(queryParam: String, completionHandler: @escaping ([ShowDetails]) -> ()) -> [ShowDetails]  {
        let urlString = "\(showURL)?q=\(queryParam)"
        performRequest(urlString: urlString) { [weak self] arr in
            completionHandler(self!.arr)
        }
        return arr
    }
    
    func performRequest(urlString: String, completionHandler: @escaping ([ShowDetails]) -> ()) {
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
                        self.arr.append(ShowDetails(dic))
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

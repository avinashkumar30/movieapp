//
//  TrendingMovieManager.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 09/05/22.
//

import Foundation
import UIKit

class TrendingMovieManager {
   let trendingMoviesURL = "https://api.themoviedb.org/3/trending/all/day?api_key=cdc953ce4c2e2684f2f49a0570adec9b"
    var trendingMovies = [Any]()
    func fetchTrendingMovies() {
        performRequest(urlString: trendingMoviesURL)
    }
    
    func performRequest(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let safeData = data {
                self.parseJSON(movieData: safeData)
            }
        }
        task.resume()
    }
    
    func parseJSON(movieData: Data) {
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with:
                                 movieData)
            if let jsonArray = jsonResponse as? [String: Any] {
                for dic in jsonArray {
                    if dic.key == "results" {
//                        print(dic.value)
                        trendingMovies.append(dic.value)
                    }
                }
            }
            for movie in trendingMovies {
                print(movie)
            }
        }
        catch {
            print(error)
        }
    }
}

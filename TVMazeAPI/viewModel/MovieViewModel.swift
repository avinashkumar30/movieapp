//
//  TrendingMovieManager.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 09/05/22.
//

import Foundation
import UIKit

class TrendingMovieViewModel {
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
            if error != nil {
                print(error!)
                return
            }else {
                if let fetchedData = data {
                    self.parseJSON(movieData: fetchedData)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(movieData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieData.self, from: movieData)
            print(decodedData.results)
        } catch {
            print(error)
        }
    }
}

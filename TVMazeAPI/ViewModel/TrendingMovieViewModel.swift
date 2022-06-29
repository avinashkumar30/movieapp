//
//  TrendingMovieManager.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 09/05/22.
//

import Foundation
import UIKit

final class TrendingMovieViewModel {
    public let trendingMoviesURL = "\(Api.movieURL)?api_key=\(Api.api_key)"
    public var trendingMovies = [Any]()
    
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

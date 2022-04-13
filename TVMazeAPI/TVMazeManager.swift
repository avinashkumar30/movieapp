//
//  TVMazeManager.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 13/04/22.
//

import Foundation
struct TVMazeManager {
    let showURL = "https://api.tvmaze.com/search/shows"
    var shows = [ShowDetails]()
    func fetchShows(queryParam: String) {
        let urlString = "\(showURL)?q=\(queryParam)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
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
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                                     dataResponse, options: [])
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                      return
                }
                var shows = [ShowDetails]()
                for dic in jsonArray {
                    shows.append(ShowDetails(dic))
                }
                for show in shows {
                    print(show)
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}

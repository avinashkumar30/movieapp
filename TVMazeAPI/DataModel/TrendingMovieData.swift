//
//  TrendingMovieData.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 09/05/22.
//

import Foundation

struct TrendingMovieData {
    var title: String
    var overview: String
    
    init(_ dictionary: Dictionary<String,Any>) {
        let movie = dictionary["results"] as! Dictionary<String,Any>
        self.title = movie["title"] as! String
        self.overview = movie["overview"] as! String
    }
}



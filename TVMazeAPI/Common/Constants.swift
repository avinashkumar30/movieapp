//
//  Constants.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 24/06/22.
//

import Foundation

enum Api {
    static let showURL = "https://api.tvmaze.com/search/shows"
    static let movieURL = "https://api.themoviedb.org/3/trending/all/day"
    static let api_key = "cdc953ce4c2e2684f2f49a0570adec9b"
}

enum Image {
    static let imageNotFoundURL = "https://cdn-www.gamerevolution.com/assets/uploads/2021/09/Plex-unexpected-error-message-fix-640x360.jpg"
}

enum Constants {
    static let rowHeight = 70
    static let homePageNumberOfRowsInSection = 1
    static let homePageRowHeight = 150
    static let homePageHeaderHeight = 50
    static let viewHeight = 40
}

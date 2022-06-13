//
//  ShowDetailVC.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 13/04/22.
//

import UIKit
import CoreData

class ShowDetailVC: UIViewController {
    let databaseManager = DataBaseManager()
    let tvMazeViewModel = TVMazeViewModel()
    
    var shows: ShowDetails?
    var likeButton: UIButton!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var rating: UILabel!
    
    @IBAction func AddToFavorites(_ sender: UIButton) {
        likeButton = sender
        var currentSelectedShow = shows!
        var alreadyFavorite = false
        
        let newFavoriteShow = Show(context: databaseManager.context)
        newFavoriteShow.score = currentSelectedShow.score
        newFavoriteShow.imageURL = currentSelectedShow.imageURL
        newFavoriteShow.name = currentSelectedShow.name
        newFavoriteShow.isLiked = true
        currentSelectedShow.isLiked = true
        
        if newFavoriteShow.isLiked {
            for show in tvMazeViewModel.favoriteShows {
                if show.name == currentSelectedShow.name {
                    alreadyFavorite = true
                    break
                }
            }
            
            if !alreadyFavorite {
                tvMazeViewModel.favoriteShows.append(newFavoriteShow)
                sender.setTitle("♥️", for: .normal)
            }
        }
        
        //saving favorites to CoreData
        databaseManager.saveItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = shows?.name
        rating.text = "Rating: \(shows?.score ?? 0)"
        
        //using image url to show image
        if let shows = shows {
            if let url = URL(string: shows.imageURL) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            self.showImage.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }
}


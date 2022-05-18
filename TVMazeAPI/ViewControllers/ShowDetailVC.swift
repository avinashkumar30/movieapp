//
//  ShowDetailVC.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 13/04/22.
//

import UIKit
import CoreData

class ShowDetailVC: UIViewController {
    var shows: ShowDetails?
    var likeButton: UIButton!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var rating: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func AddToFavorites(_ sender: UIButton) {
        print("clicked")
        likeButton = sender
        let tvMazeManager = TVMazeManager()
        var currentSelectedShow = shows!
        
//        if currentSelectedShow.isLiked {
//            currentSelectedShow.isLiked = false
//            sender.setTitle("♡", for: .normal)
//        }
        
        let newFavoriteShow = Show(context: context)
        
        var alreadyFavorite = false
        newFavoriteShow.score = currentSelectedShow.score
        newFavoriteShow.imageURL = currentSelectedShow.imageURL
        newFavoriteShow.name = currentSelectedShow.name
        newFavoriteShow.isLiked = true
        currentSelectedShow.isLiked = true
        
        if newFavoriteShow.isLiked {
            for show in tvMazeManager.favoriteShows {
                if show.name == currentSelectedShow.name {
                    alreadyFavorite = true
                    break
                }
            }
            
            if !alreadyFavorite {
                tvMazeManager.favoriteShows.append(newFavoriteShow)
                sender.setTitle("♥️", for: .normal)
            }
        }
        
        do{
            try context.save()
        } catch {
            print("Error saving the data")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = shows?.name
        rating.text = "Rating: \(shows?.score ?? 0)"
        
        let url = URL(string: shows!.imageURL)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.showImage.image = UIImage(data: data!)
            }
        }
    }
    
}


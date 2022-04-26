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
   
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var rating: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func AddToFavorites(_ sender: UIButton) {
        print("clicked")
        let tvMazeManager = TVMazeManager()
        let currentSelectedShow = shows!
        var alreadyFavorite = false
        let newFavoriteShow = Show(context: context)
        newFavoriteShow.score = currentSelectedShow.score
        newFavoriteShow.imageURL = currentSelectedShow.imageURL
        newFavoriteShow.name = currentSelectedShow.name
//        newFavoriteShow.isLiked = true
        //searching if show already exists in the favoriteShows
        for show in tvMazeManager.favoriteShows {
            if show == newFavoriteShow {
                alreadyFavorite = true
                break
            }
        }
        
        if sender.currentTitle == "♡" {
            DispatchQueue.main.async {
                sender.setTitle("♥️", for: .normal)
            }
            
            //if not then only add it
            if !alreadyFavorite {
                tvMazeManager.favoriteShows.append(newFavoriteShow)
            }
                
        } else {
            for _ in tvMazeManager.favoriteShows {
                tvMazeManager.favoriteShows.removeAll {
                    show in show == newFavoriteShow
                }
            }
            
            DispatchQueue.main.async {
                sender.setTitle("♡", for: .normal)
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


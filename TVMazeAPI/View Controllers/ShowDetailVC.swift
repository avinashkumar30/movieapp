//
//  ShowDetailVC.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 13/04/22.
//

import UIKit

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
        let newFavoriteShow = Show(context: context)
        newFavoriteShow.score = currentSelectedShow.score
        newFavoriteShow.imageURL = currentSelectedShow.imageURL
        newFavoriteShow.name = currentSelectedShow.name
        tvMazeManager.favoriteShows.append(newFavoriteShow)
        sender.self.titleLabel = UIFont(name: "♥️", size: 20)
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

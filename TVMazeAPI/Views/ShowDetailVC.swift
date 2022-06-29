//
//  ShowDetailVC.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 13/04/22.
//

import UIKit
import CoreData

final class ShowDetailVC: UIViewController {
    private let dataBaseHandler = DataBaseHandler()
    private let showViewModel = ShowViewModel()
    private var likeButton: UIButton!
    public var shows: ShowModel?
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var rating: UILabel!
    
    @IBAction func AddToFavorites(_ sender: UIButton) {
        likeButton = sender
        if let shows = shows {
            if dataBaseHandler.addToFavorites(shows: shows) {
                sender.setTitle("♥️", for: .normal)
            }
        }
        
        //saving favorites to CoreData
        dataBaseHandler.saveItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = shows?.name
        
        let score = Double(round(1000 * (shows?.score ?? 0) / 1000))
        rating.text = "Rating: \(score*5)"
        
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


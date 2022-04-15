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

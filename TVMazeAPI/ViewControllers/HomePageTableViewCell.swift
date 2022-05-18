//
//  HomePageTableViewCell.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 11/05/22.
//

import UIKit
import CoreData

class HomePageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var homePageCollectionView: UICollectionView!
//    var trendingShows = [Show]()
    var favoriteShows = [Show]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func awakeFromNib() {
        super.awakeFromNib()
        homePageCollectionView.delegate = self
        homePageCollectionView.dataSource = self
        loadItems()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension HomePageTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homePageCollectionView.dequeueReusableCell(withReuseIdentifier: "HomePageTableCollectionViewCell", for: indexPath) as! HomePageCollectionViewCell
        
        let url = URL(string: favoriteShows[indexPath.row].imageURL!)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.movieImage.image = UIImage(data: data!)
            }
        }
        return cell
    }
}

// MARK :- Fetching all shows from database
extension HomePageTableViewCell {
    func loadItems() {
        let request: NSFetchRequest<Show> = Show.fetchRequest()
        do {
            favoriteShows = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}

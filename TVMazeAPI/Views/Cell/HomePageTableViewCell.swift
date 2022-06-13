//
//  HomePageTableViewCell.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 11/05/22.
//

import UIKit
import CoreData

class HomePageTableViewCell: UITableViewCell {
    
    var favoriteShows = [Show]()
    let dataBaseManager = DataBaseManager()

    @IBOutlet weak var homePageCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        homePageCollectionView.delegate = self
        homePageCollectionView.dataSource = self
        loadItems()
        TrendingMovieViewModel().fetchTrendingMovies()
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
        
        guard let cell = homePageCollectionView.dequeueReusableCell(withReuseIdentifier: "HomePageTableCollectionViewCell", for: indexPath) as?  HomePageCollectionViewCell else {
            fatalError()
        }
        
        if let url = URL(string: favoriteShows[indexPath.row].imageURL!) {
            DispatchQueue.main.async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.movieImage.image = UIImage(data: data)
                    }
                }
            }
        }
        return cell
    }
    
    
    func loadItems() {
        let request: NSFetchRequest<Show> = Show.fetchRequest()
        do {
            let context = dataBaseManager.context
            favoriteShows = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }

}


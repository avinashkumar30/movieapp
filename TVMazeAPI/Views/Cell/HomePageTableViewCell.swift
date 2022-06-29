//
//  HomePageTableViewCell.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 11/05/22.
//

import UIKit
import CoreData

final class HomePageTableViewCell: UITableViewCell {
    
    private var favoriteShows = [Show]()
    private let dataBaseHandler = DataBaseHandler()
    private let showViewModel = ShowViewModel()
    
    @IBOutlet weak var homePageCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        homePageCollectionView.delegate = self
        homePageCollectionView.dataSource = self
        dataBaseHandler.loadItems() { [weak self] showData in
            self?.favoriteShows = showData
        }
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
        
        if let url = URL(string: favoriteShows[indexPath.row].imageURL ?? Image.imageNotFoundURL) {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.movieImage.image = UIImage(data: data)
                    }
                }
        }
        return cell
    }
}


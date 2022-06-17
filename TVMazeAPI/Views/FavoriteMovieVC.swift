//
//  FavoriteMovieVC.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 29/04/22.
//

import UIKit
import CoreData

class FavoriteMovieVC: UIViewController {
    
    let showViewModel = ShowViewModel()
    let databaseManager = DataBaseManager()
    
    var shows = [Show]()
    
    @IBOutlet weak var MovieCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieCollectionView.reloadData()
        databaseManager.loadItems() { [weak self] ShowData in
            self?.shows = ShowData
        }
    }
}

// MARK :- UICollectionViewDataSource, UICollectionViewDelegate
extension FavoriteMovieVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteMovieCollectionViewCell", for: indexPath) as? FavoriteMovieCollectionViewCell else {
            fatalError()
        }
        
        if let url = URL(string: shows[indexPath.row].imageURL!) {
            DispatchQueue.main.async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.movieImage.image = UIImage(data: data)
                    }
                }
            }
        }
        cell.movieTitle.text = shows[indexPath.row].name
        return cell
    }
}

// MARK :- UICollectionViewDelegateFlowLayout
extension FavoriteMovieVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/2, height: 200)
    }
}

//
//  FavoriteMovieVC.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 29/04/22.
//

import UIKit
import CoreData

class FavoriteMovieVC: UIViewController {
    
    let tvMazeManager = TVMazeManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var shows = [Show]()
    
    @IBOutlet weak var MovieCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems { [weak self] ShowDetails in
            self?.shows = ShowDetails
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadItems { [weak self] ShowDetails in
            self?.shows = ShowDetails
        }
    }
}

// MARK :- UICollectionViewDataSource, UICollectionViewDelegate
extension FavoriteMovieVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteMovieCollectionViewCell", for: indexPath) as! FavoriteMovieCollectionViewCell
        let url = URL(string: shows[indexPath.row].imageURL!)
        DispatchQueue.main.async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.movieImage.image = UIImage(data: data!)
            }
        }
        cell.movieTitle.text = shows[indexPath.row].name
        return cell
    }
}

// MARK :- UICollectionViewDelegateFlowLayout
extension FavoriteMovieVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}


// MARK :- Fetching all shows from database
extension FavoriteMovieVC {
    func loadItems(completionHandler: @escaping ([Show]) -> ()) {
        let request: NSFetchRequest<Show> = Show.fetchRequest()
        do {
            shows = try context.fetch(request)
            completionHandler(shows)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}

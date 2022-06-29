//
//  HomePageViewController.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 10/05/22.
//

import UIKit

final class HomePageViewController: UIViewController {
    
    private let sections = ["Recommended For You", "Trending", "Favorites"]

    @IBOutlet weak var homePageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.homePageNumberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Constants.homePageRowHeight)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: CGFloat(Constants.viewHeight)))
        view.backgroundColor =  .black
        
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: CGFloat(Constants.viewHeight)))
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.text = sections[section]
        
        view.addSubview(lbl)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(Constants.homePageHeaderHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (homePageTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomePageTableViewCell)
        return cell!
    }
}

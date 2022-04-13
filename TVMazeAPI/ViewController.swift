//
//  ViewController.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 04/04/22.
//

import UIKit

  
    
//    func parseJSON(showData: Data) {
//        guard let jsonArray = jsonResponse as? [[String: Any]] else {
//              return
//        }
//        print(jsonArray)
//    }

class ViewController: UIViewController {

    @IBOutlet weak var showName: UITextField!
    @IBOutlet weak var tableView: UITableView!
   
    let tvMazeManager = TVMazeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func Search(_ sender: Any) {
        tvMazeManager.fetchShows(queryParam: showName.text ?? "boys")
    }
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "nsdc"
        return cell
    }
}

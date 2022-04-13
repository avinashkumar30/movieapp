//
//  ViewController.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 04/04/22.
//

import UIKit

struct TVMazeManager {
    let showURL = "https://api.tvmaze.com/search/shows"
    
    func fetchShows(queryParam: String) {
        let urlString = "\(showURL)?q=\(queryParam)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                                     dataResponse, options: [])
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                      return
                }
                var shows = [ShowDetails]()
                for dic in jsonArray {
                    shows.append(ShowDetails(dic))
                }
                for show in shows {
                    print(show)
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        
        task.resume()
        
    }
    
    
//    func parseJSON(showData: Data) {
//        guard let jsonArray = jsonResponse as? [[String: Any]] else {
//              return
//        }
//        print(jsonArray)
//    }
    
}

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

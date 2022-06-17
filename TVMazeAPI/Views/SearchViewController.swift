import UIKit
import CoreData

class SearchViewController: UIViewController {
    
    let showViewModel = ShowViewModel()
    let trendingMovieViewModel = TrendingMovieViewModel()
    let dataBaseManager = DataBaseManager()
    
    //storing the results in "shows" so as to iterate on it inorder to show on the tableview
    var shows = [ShowModel]()
    
    @IBOutlet weak var showName: UITextField!
    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func Search(_ sender: Any) {
        showViewModel.fetchShows(queryParam: showName.text ?? "boys") { [weak self] showData in
            self?.shows = showData
            DispatchQueue.main.async {
               self?.tableView.reloadData()
           }
       }
       showName.text = ""
    }
}

// MARK: - TableView Delegate Methods

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = shows[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showdetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension SearchViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ShowDetailVC {
            if let index = (tableView.indexPathForSelectedRow?.row) {
                destination.shows = shows[index]
            }
        }
    }
}
    


//        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
//        print(dataFilePath)

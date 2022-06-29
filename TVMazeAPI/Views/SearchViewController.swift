import UIKit
import CoreData

final class SearchViewController: UIViewController {
    
    private let showViewModel = ShowViewModel()
    
    @IBOutlet weak var showName: UITextField!
    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func Search(_ sender: Any) {
        showViewModel.fetchShows(queryParam: showName.text ?? "boys") {_ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
           }
       }
       showName.text = ""
    }
}

// MARK: - TableView Delegate Methods

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showViewModel.numberOfShows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = showViewModel.getShow(indexPath: indexPath).name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showdetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Constants.rowHeight)
    }
}

extension SearchViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ShowDetailVC {
            if let index = (tableView.indexPathForSelectedRow?.row) {
                destination.shows = showViewModel.getShow(index: index)
            }
        }
    }
}

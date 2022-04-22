import UIKit
import CoreData

class ViewController: UIViewController {

    var arr = [ShowDetails]()
    var favoriteShows = TVMazeManager().favoriteShows

    let tvMazeManager = TVMazeManager()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var showName: UITextField!
    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        print(dataFilePath)
        loadItems()
    }
    
    @IBAction func Search(_ sender: Any) {
        arr = tvMazeManager.fetchShows(queryParam: showName.text ?? "boys")
        tableView.reloadData()
        showName.text = ""
    }
}

// MARK: - TableView Delegate Methods

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.arr[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showdetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ShowDetailVC {
            destination.shows = arr[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    //MARK: - Model Manipulation methods

    func saveItems() {
        do{
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }

    func loadItems() {
        let request: NSFetchRequest<Show> = Show.fetchRequest()
        do {
            favoriteShows = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}


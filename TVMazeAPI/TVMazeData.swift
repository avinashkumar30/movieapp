import Foundation

struct ShowDetails {
    var score: Double
    var id: Int
    var name: String
    
    init(_ dictionary: Dictionary<String,Any>) {
        self.score = dictionary["score"] as? Double ??  0
        let show = dictionary["show"] as! Dictionary<String,Any>
        self.id = (show["id"] as! Int)
        self.name = (show["name"] as! String)
    }
}


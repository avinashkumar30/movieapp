import Foundation
import UIKit

struct ShowDetails {
    var score: Double
    var id: Int
    var name: String
    var imageURL: String
    
    init(_ dictionary: Dictionary<String,Any>) {
        self.score = dictionary["score"] as? Double ??  0
        let show = dictionary["show"] as! Dictionary<String,Any>
        self.id = (show["id"] as! Int)
        self.name = (show["name"] as! String)
        let images = show["image"] as? Dictionary<String,Any>
//        imageURL = images["medium"]
        if let imagePath = images as? Dictionary<String,String> {
            imageURL = imagePath["medium"]!
        } else {
            imageURL = "https://cdn-www.gamerevolution.com/assets/uploads/2021/09/Plex-unexpected-error-message-fix-640x360.jpg"
        }
    }
}


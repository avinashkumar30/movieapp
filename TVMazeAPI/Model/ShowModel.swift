import Foundation
public struct ShowModel: Codable {
    public var score: Double
    public var name: String
    public var imageURL: String
    public var isLiked: Bool

    init(_ dictionary: Dictionary<String,Any>) {
        let show = dictionary["show"] as! Dictionary<String,Any>
        let images = show["image"] as? Dictionary<String,Any>

        self.score = dictionary["score"] as? Double ?? 0
        self.name = (show["name"] as! String)
        self.isLiked = false

        if let imagePath = images as? Dictionary<String,String> {
            imageURL = imagePath["medium"]!
        } else {
            imageURL = Image.imageNotFoundURL
        }
    }
}


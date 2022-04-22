//
//  TVC.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 04/04/22.
//

import UIKit

class TVC: UITableViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

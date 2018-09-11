//
//  ProfileTableViewCell.swift
//  Lambo
//
//  Created by Sreekanth Gudisi on 27/08/18.
//  Copyright © 2018 simplyfi.apps. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var array1Label: UILabel!
    @IBOutlet weak var array2Label: UILabel!
    @IBOutlet weak var array3Label: UILabel!
    
    
    @IBOutlet weak var myImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

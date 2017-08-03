//
//  FavoritedGameTableViewCell.swift
//  VivaRealChallenge
//
//  Created by Hoff Henry Pereira da Silva on 03/08/17.
//  Copyright © 2017 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit

class FavoritedGameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewCoverGame: UIImageView!
    @IBOutlet weak var labelNameGame: UILabel!
    @IBOutlet weak var labelPopularity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

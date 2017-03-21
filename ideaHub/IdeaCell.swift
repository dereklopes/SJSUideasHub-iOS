//
//  IdeaCell.swift
//  ideaHub
//
//  Created by Derek Lopes on 3/21/17.
//  Copyright © 2017 San Jose State University. All rights reserved.
//

import UIKit

class IdeaCell: UITableViewCell {

    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

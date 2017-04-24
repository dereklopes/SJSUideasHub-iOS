//
//  IdeaViewController.swift
//  ideaHub
//
//  Created by Derek Lopes on 4/23/17.
//  Copyright © 2017 San Jose State University. All rights reserved.
//

import UIKit

class IdeaViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    var idea : Idea?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let idea = idea {
            titleLabel.text = idea.title
            titleLabel.sizeToFit()
            dateLabel.text = idea.date
            descriptionLabel.text = idea.content
            descriptionLabel.sizeToFit()
            categoryLabel.text = idea.category
            likesLabel.text = String(describing: idea.likes)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

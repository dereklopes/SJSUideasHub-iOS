//
//  IdeaViewController.swift
//  ideaHub
//
//  Created by Derek Lopes on 4/23/17.
//  Copyright © 2017 San Jose State University. All rights reserved.
//

import UIKit
import GoogleSignIn

class IdeaViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    
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
            emailButton.setTitle(idea.author, for: .normal)
        }
        
        // user/email button
        emailButton.addTarget(self, action: #selector(userOptions), for: .touchUpInside)
    }
    
    @IBAction func userOptions() {
        // initialize alert controller
        let userAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // create set with actions
        let userActions : Set<UIAlertAction> = [
            // switches to home view to view all posts by user
            UIAlertAction(title: "ViewPosts", style: .default, handler: {_ in (self.viewPostsHandler())}),
            // cancel button
            UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ]
        // add actions to alert controller
        for userAction in userActions {
            userAlert.addAction(userAction)
        }
        // show alert
        self.present(userAlert, animated: true)
    }
    
    func viewPostsHandler() {
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
        let viewPostsSegue = UIStoryboardSegue(identifier: "ViewPostsSegue", source: self, destination: homeViewController!)
        prepare(for: viewPostsSegue, sender: self)
        self.navigationController?.pushViewController(homeViewController!, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "ViewPostsSegue":
            guard let homeViewController = segue.destination as? HomeViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            homeViewController.author = (self.idea?.author)!
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }

}

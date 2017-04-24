//
//  UserViewController.swift
//  ideaHub
//
//  Created by Derek Lopes on 4/21/17.
//  Copyright © 2017 San Jose State University. All rights reserved.
//

import UIKit
import GoogleSignIn

class UserViewController: UIViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var signOutButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set user data
        let userProfile = GIDSignIn.sharedInstance().currentUser.profile
        nameLabel.text = userProfile?.name!
        emailLabel.text = userProfile?.email!
        if (userProfile?.hasImage)! {
            let imageUrl = userProfile?.imageURL(withDimension: 120)
            let pictureData = NSData(contentsOf: imageUrl!)! as Data
            profilePicture.image = UIImage(data: pictureData)
        }
        
        // set sign out button functionality
        signOutButton.action = #selector(googleSignOut(sender:))
        signOutButton.target = self
    }
    
    func googleSignOut(sender: UIBarButtonItem) {
        GIDSignIn.sharedInstance().disconnect()
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

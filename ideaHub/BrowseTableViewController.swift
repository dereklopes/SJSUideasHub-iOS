//
//  BrowseTableViewController.swift
//  ideaHub
//
//  Created by Derek Lopes on 4/24/17.
//  Copyright © 2017 San Jose State University. All rights reserved.
//

import UIKit

class BrowseTableViewController: UITableViewController {
    @IBOutlet weak var categoryTable: UITableView!
    
    var categories = ["Literature", "Business", "Education", "Art",
                      "Finance", "Games", "Fitness", "Lifestyle",
                      "Science", "Music", "Video", "Photography",
                      "Shopping", "Social", "Sports", "Travel",
                      "Technology"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        categories.sort()
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCell

        // Configure the cell
        cell.categoryLabel.text = categories[indexPath.item]

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "ShowCategory":
            guard let homeViewController = segue.destination as? HomeViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedCategoryCell = sender as? CategoryCell else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let indexPath = categoryTable.indexPath(for: selectedCategoryCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedCategory = categories[indexPath.row]
            homeViewController.category = selectedCategory
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }

    }

}

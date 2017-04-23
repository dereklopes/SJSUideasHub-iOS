//
//  HomeViewController.swift
//  ideaHub
//
//  Created by Derek Lopes on 3/21/17.
//  Copyright © 2017 San Jose State University. All rights reserved.
//

import UIKit
import GoogleSignIn

class HomeViewController: UITableViewController {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    var ideas: [Idea]? = []
    
    enum sortTypes {
        case newest
        case likes
        case oldest
    }
    
    var sortBy = sortTypes.newest

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up sort button
        sortButton.action = #selector(sortIdeas(sender:))
        sortButton.target = self
        
        // get ideas
        fetchIdeas()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    // brings up UIAlert to set sortBy
    func sortIdeas(sender: UIBarButtonItem) {
        // initialize controller
        let sortAlert = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)
        // add acitons
        let sortActions : Set<UIAlertAction> = [
            UIAlertAction(title: "Newest", style: .default, handler: {_ in (self.setSortBy(type: sortTypes.newest))}),
            UIAlertAction(title: "Oldest", style: .default, handler: {_ in (self.setSortBy(type: sortTypes.oldest))}),
            UIAlertAction(title: "Likes", style: .default, handler: {_ in (self.setSortBy(type: sortTypes.likes))}),
            UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ]
        for sortAction in sortActions {
            sortAlert.addAction(sortAction)
        }
        // show alert
        self.present(sortAlert, animated: true)
    }
    
    func setSortBy(type: sortTypes) {
        sortBy = type
        fetchIdeas()
    }
    
    // fetches idea objects from server in JSON format
    func fetchIdeas() {
        var urlRequest : URLRequest
        if (sortBy == sortTypes.newest) {
            urlRequest = URLRequest(url: URL(string:"https://derkle.pythonanywhere.com/ideas/?sort=newest")!)
        }
        else if(sortBy == sortTypes.likes) {
            urlRequest = URLRequest(url: URL(string:"https://derkle.pythonanywhere.com/ideas/?sort=likes")!)
        } else if (sortBy == sortTypes.oldest) {
            urlRequest = URLRequest(url: URL(string:"https://derkle.pythonanywhere.com/ideas/?sort=oldest")!)
        } else {
            urlRequest = URLRequest(url: URL(string:"https://derkle.pythonanywhere.com/ideas")!)
        }
        // create a new session for gathering info from URL
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
         
            if error != nil {
                print(error!)
                return
            }
            
            self.ideas = [Idea]()
            do {
                // get the JSON object into a dictionary
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [[String : AnyObject]]
                
                // create an Idea object for each JSON object in dictionary
                for ideaFromJson in json {
                    // grab data from JSON object
                    if let title = ideaFromJson["title"] as? String, let id = ideaFromJson["ideaId"] as? Int, let content = ideaFromJson["content"] as? String, let date = ideaFromJson["date"] as? String, let category = ideaFromJson["category"] as? String, let likes = ideaFromJson["likes"] as? Int, let author = ideaFromJson["author"] as? String {
                        let idea = Idea(id: id, title: title, content: content, date: date, category: category, likes: likes, author: author)
                        self.ideas?.append(idea)
                    }
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
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
        return self.ideas?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ideaCell", for: indexPath) as! IdeaCell

        cell.title.text = self.ideas?[indexPath.item].title
        cell.desc.text = self.ideas?[indexPath.item].content
        cell.date.text = self.ideas?[indexPath.item].date
        cell.category.text = self.ideas?[indexPath.item].category
        cell.likes.text = "Likes: \(self.ideas![indexPath.item].likes)"
        //cell.likes.text = String(describing: self.ideas?[indexPath.item].likes)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

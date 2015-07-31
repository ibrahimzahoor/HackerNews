//
//  NewsFeedTableViewController.swift
//  Hacker News
//
//  Created by ibrahim on 27/07/2015.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class NewsFeedTableViewController: UITableViewController {

    var titles = [String]()
    var usernames = [String]()
    var newstexts = [String]()
    var objectId = [AnyObject]()
    
    var refresher:UIRefreshControl!
    
    
    func displayAlert(title: String, error: String) {
        
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
            action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    @IBAction func LogoutButton(sender: AnyObject) {
        
        PFUser.logOut()
        
        /*var currentUser = PFUser.currentUser()
        if currentUser == nil {
            
             displayAlert("Logout!", error: "User Successfully loged out")
        }
        else {
             displayAlert("Error!", error: "Error logging out ")
        }*/
        
        
        self.performSegueWithIdentifier("logout", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
        /*var query = PFQuery(className: "News")
        query.cachePolicy = .CacheThenNetwork
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                println("Succesfully Retrieved \(objects!.count) News")
            
            
                for object in objects! {
                
                    self.titles.append(object["Title"] as! String)
                    self.newstexts.append(object["Description"] as! String)
                    self.usernames.append(object["User"] as! String)
                    
                    self.tableView.reloadData()
                
                }
            }
            else {
                println(error)
            }
            
        }*/
        
        loadResults()
    
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresher)
    
    }

    func loadResults() {
        
        var query = PFQuery(className: "News")
        query.cachePolicy = .CacheThenNetwork
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                println("Succesfully Retrieved \(objects!.count) News")
                
                self.titles.removeAll()
                self.usernames.removeAll()
                self.newstexts.removeAll()
                self.objectId.removeAll()
                
                for object in objects! {
                    
                    self.titles.append(object["Title"] as! String)
                    self.newstexts.append(object["Description"] as! String)
                    self.usernames.append(object["User"] as! String)
                    self.objectId.append(object.objectId)
                }
                
                self.tableView.reloadData()
            }
            else {
                println(error)
            }
            
        }

    }
    
    func refresh() {
        
        loadResults()
        
        self.refresher.endRefreshing()
        
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
            
            
            var query = PFQuery(className: "News")
            
            query.getObjectInBackgroundWithId(self.objectId[indexPath.row] as! String) {
                (gameScore: PFObject?, error: NSError?) -> Void in
                if error == nil && gameScore != nil {
                    
                    println(self.objectId[indexPath.row] as! String)
                    
                    gameScore?.deleteInBackground()
                    //gameScore?.saveInBackground()
                
                    
                } else {
                    println(error)
                }

            }
            self.objectId.removeAtIndex(indexPath.row)
            self.titles.removeAtIndex(indexPath.row)
            self.newstexts.removeAtIndex(indexPath.row)
            self.usernames.removeAtIndex(indexPath.row)
            
            loadResults()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return titles.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:NewsFeedTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("NewsCell", forIndexPath: indexPath) as! NewsFeedTableViewCell
        
        cell.titleLabel.text = titles[indexPath.row]
        cell.textNews.text = newstexts[indexPath.row]
        cell.username.text = usernames[indexPath.row]
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

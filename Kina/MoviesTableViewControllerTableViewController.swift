//
//  myTableViewController.swift
//  The one viewer
//
//  Created by Mailo Svetel on 01/10/14.
//  Copyright (c) 2014 Mailo Svetel. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    var myData : NSMutableArray = []
    
    override func viewDidLoad() {
//        super.viewDidLoad()
        
        loadMovies()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadMovies() {
        let net = Net(baseUrlString: "http://pipes.yahoo.com")
        let params = ["_id": "4de0bb303324b7fc764cae83e4c9abde", "_render": "json"]
        
        net.GET(
            "/pipes/pipe.run",
            params: params,
            successHandler: {
                responseData in let result = responseData.json(error: nil)
                //                NSLog("result \(result)")
                
                let theValue = result!.objectForKey("value") as NSDictionary!
                let items = theValue!.objectForKey("items") as NSArray!
                
                let titleOne: NSString! = items[0].valueForKey("title") as NSString
                
//                NSLog("\(titleOne)")
                
                for movie in items {
//                    let thisTitle = movie.objectForKey("title")
//                    NSLog("\(thisTitle)")
                    self.myData.addObject(movie as NSDictionary)
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
                
            },
            failureHandler: {
                error in NSLog("Error")
            }
        )

    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        var theCount = myData.count
        
        NSLog("Counting: \(theCount)")
        
        return myData.count
        
    }
    
    //*
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell {
        let cellId : String = "myCell"
        
        var cell : UITableViewCell = tableView?.dequeueReusableCellWithIdentifier(cellId) as UITableViewCell
        
        NSLog("\(indexPath)")
        
        if let ip = indexPath {
            var thisTitle = myData[ip.row].objectForKey("title")
            
            NSLog("\(thisTitle)")
            
            cell.textLabel?.text = (thisTitle as String)
            NSLog("\(cell.textLabel?.text)")
        }
        
        return cell
    }
    //*/
    
    //*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    //*/
    
    //*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath?) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            if let tv = tableView {
                myData.removeObjectAtIndex(indexPath!.row)
                tv.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            }
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    //*/
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}

//
//  ResultViewController.swift
//  Restaurant Finder
//
//  Created by Jianxin Gao on 5/20/16.
//  Copyright © 2016 Jianxin Gao. All rights reserved.
//

import Foundation
import UIKit
import LinearProgressBar

class ResultViewController: UITableViewController {
    var businesses: [Business] = []
    
    // for query parameters
    var keyword: String = ""
    var sortMode: YelpSortMode = .Distance
    var location: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 86
        
        self.navigationItem.title = "Results"
        // add a 'Done' button in the navigation bar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(ResultViewController.dismissSelf))
        
        // progress bar animation
        let progressBar = LinearProgressBar()
        self.view.addSubview(progressBar)
        progressBar.startAnimation()
        
        
        // start the search
        if let location = location {
            YelpClient.sharedInstance.location = location
        }
        Business.searchWithTerm(keyword, sort: sortMode, categories: [], deals: false) { (businesses: [Business]!, error: NSError!) -> Void in
            
            progressBar.stopAnimation()
            self.businesses = businesses
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        let business = businesses[indexPath.row]
        
        cell.nameLabel.text = business.name
        cell.addressLabel.text = business.address
        
        return cell
    }
    
    // method to dismiss this view itself, called when `done` button clicked
    func dismissSelf() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
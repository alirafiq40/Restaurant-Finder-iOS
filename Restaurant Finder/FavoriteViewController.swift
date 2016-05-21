//
//  FavoriteViewController.swift
//  Restaurant Finder
//
//  Created by Jianxin Gao on 5/20/16.
//  Copyright © 2016 Jianxin Gao. All rights reserved.
//

import Foundation
import UIKit

class FavoriteViewController: UITableViewController {
    var businesses: [Business] = []
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        let business = businesses[indexPath.row]
        
        cell.nameLabel.text = business.name
        cell.addressLabel.text = business.address
        Util.downloadImage(business.imageURL!, imageView: cell.businessImage)
        Util.downloadImage(business.ratingImageURL!, imageView: cell.ratingImage)
        cell.ratingLabel.text = business.rating
        cell.distanceLabel.text = business.distance
        
        return cell
    }
}
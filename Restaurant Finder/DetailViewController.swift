//
//  DetailViewController.swift
//  Restaurant Finder
//
//  Created by Jianxin Gao on 5/20/16.
//  Copyright © 2016 Jianxin Gao. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var business: Business!
    var cell: BusinessCell?
    
    @IBOutlet var googleStaticImageView: UIImageView!
    @IBOutlet var snippetLabel: UILabel!
    @IBOutlet var snippetImageView: UIImageView!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var reviewCountsLabel: UILabel!
    @IBOutlet var ratingImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var favButton: DOFavoriteButton!
    @IBOutlet var addressLabel: UILabel!
    
    
    @IBAction func favButtonClicked(sender: DOFavoriteButton) {
        if sender.selected {
            // deselect
            sender.deselect()
        } else {
            // select with animation
            sender.select()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = business.name
        
        Util.downloadImage(business.snippetURL!, imageView: snippetImageView)
        print(business.snippetURL)
        Util.downloadImage(business.googleStaticMapURL!, imageView: googleStaticImageView)
        snippetLabel.text = "\"\(business.snippetText!)\""
        
        distanceLabel.text = business.distance
        phoneLabel.text = business.phone
        reviewCountsLabel.text = "\(business.reviewCount!) reviews"
        if let cell = cell {
            ratingImageView.image = cell.ratingImage.image
            restaurantImageView.image = cell.businessImage.image
        } else {
            Util.downloadImage(business.ratingImageURL!, imageView: ratingImageView)
            Util.downloadImage(business.imageURL!, imageView: restaurantImageView)
        }
        nameLabel.text = business.name
        addressLabel.text = business.address
    }
}
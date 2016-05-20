//
//  SearchViewController.swift
//  Restaurant Finder
//
//  Created by Jianxin Gao on 5/20/16.
//  Copyright © 2016 Jianxin Gao. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    let searchBar = UISearchBar()
    var placePicker: GMSPlacePicker?
    var nameLabel = UILabel()
    var addressLabel = UILabel()
    
    override func loadView() {
        super.loadView()
        
        // add segmented control
        let segmentedControl = UISegmentedControl(items: ["By Distance", "By Relevance"])
        segmentedControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let margins = view.layoutMarginsGuide
        let topConstraint = segmentedControl.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
        let leadingConstraint = segmentedControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        
        topConstraint.active = true
        leadingConstraint.active = true
        trailingConstraint.active = true
        
        // add location's name label
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "San Jose Downtown (Default location)"
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.backgroundColor = view.tintColor
        let topConstraintForNameLabel = nameLabel.topAnchor.constraintEqualToAnchor(segmentedControl.bottomAnchor, constant: 16)
        let leadingConstraintForNameLabel = nameLabel.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingConstraintForNameLabel = nameLabel.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        topConstraintForNameLabel.active = true
        leadingConstraintForNameLabel.active = true
        trailingConstraintForNameLabel.active = true
        
        // add location's address label
        view.addSubview(addressLabel)
        addressLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        addressLabel.numberOfLines = 0
        addressLabel.textColor = view.tintColor
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        let topConstraintForAddressLabel = addressLabel.topAnchor.constraintEqualToAnchor(nameLabel.bottomAnchor, constant: 8)
        let leadingConstraintForAddressLabel = addressLabel.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingConstraintForAddressLabel = addressLabel.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        topConstraintForAddressLabel.active = true
        leadingConstraintForAddressLabel.active = true
        trailingConstraintForAddressLabel.active = true
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add `place` icon in the navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_location_on"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SearchViewController.locationButtonClicked))
        navigationItem.titleView = searchBar
    }
    
    func locationButtonClicked() {
        let center = CLLocationCoordinate2DMake(37.788204, -122.411937)
        let northEast = CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001)
        let southWest = CLLocationCoordinate2DMake(center.latitude - 0.001, center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        placePicker = GMSPlacePicker(config: config)
        
        placePicker?.pickPlaceWithCallback({ (place: GMSPlace?, error: NSError?) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let place = place {
                self.nameLabel.text = place.name
                if let address = place.formattedAddress {
                    self.addressLabel.text = address.componentsSeparatedByString(", ").joinWithSeparator("\n")
                } else {
                    self.addressLabel.text = ""
                }
                
                
            } else {
                self.nameLabel.text = "No place selected"
                self.addressLabel.text = ""
            }
        })
    }
    
}

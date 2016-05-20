//
//  SearchViewController.swift
//  Restaurant Finder
//
//  Created by Jianxin Gao on 5/20/16.
//  Copyright © 2016 Jianxin Gao. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class SearchViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {
    
    let searchBar = UISearchBar()
    let mapView = MKMapView()
    
    override func loadView() {
        super.loadView()
        view = mapView
        mapView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.titleView = searchBar
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        <#code#>
    }
    
    
}

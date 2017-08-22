//
//  SecondCardViewController.swift
//  DiningMode
//
//  Created by Adrian Cheng on 8/21/17.
//  Copyright © 2017 OpenTable, Inc. All rights reserved.
//

import UIKit
import MapKit

class SecondCardViewController: CardViewController {

    @IBOutlet var label: UILabel!
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan // Debug colors
        
        mapView.isZoomEnabled = false;
        mapView.isScrollEnabled = false;
        mapView.isUserInteractionEnabled = false;
    }
    
    
    override func configure(reservation: Reservation) {
        label.text = String(format: "%@: %@", NSLocalizedString("Address", comment: "Address"), reservation.restaurant.fullAddress())
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = reservation.restaurant.location.coordinate
        mapView.showAnnotations([annotation], animated: true)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        mapView.regionThatFits(region)
    }
    
}

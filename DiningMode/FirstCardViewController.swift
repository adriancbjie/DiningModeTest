//
//  FirstCardViewController.swift
//  DiningMode
//
//  Created by Adrian Cheng on 8/21/17.
//  Copyright © 2017 OpenTable, Inc. All rights reserved.
//

import UIKit
import AFNetworking

class FirstCardViewController: CardViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .purple // Debug colors
    }
    
    override func configure(reservation: Reservation) {
        if let imageURLString = reservation.restaurant.profilePhoto?.urlForSize(desiredSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) {
            if let url = URL(string: imageURLString) {
                imageView.setImageWith(url)
            }
        }
        
        let reservationDateText = CustomDateFormatters.humanReadableFormatter.string(from: reservation.localDate)
        label.text = String(format:"%@: %@ \n %@: %@ \n %@: %llu",
                            NSLocalizedString("Reservation Name", comment: "Reservation Name"),
                            reservation.restaurant.name,
                            NSLocalizedString("At time", comment: "At time"),
                            reservationDateText,
                            NSLocalizedString("Party size", comment: "Party Size"),
                            reservation.partySize)
    }

}

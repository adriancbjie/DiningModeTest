//
//  ThirdCardViewController.swift
//  DiningMode
//
//  Created by Adrian Cheng on 8/21/17.
//  Copyright © 2017 OpenTable, Inc. All rights reserved.
//

import UIKit

class ThirdCardViewController: CardViewController {
    static let dishLimit = 3 // Max limit of number of dishes allowed
    
    @IBOutlet var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGray // Debug colors
    }
    
    override func configure(reservation: Reservation) {
        guard reservation.restaurant.dishes.count > 0 else {
            return
        }
        
        let dishCount = min(ThirdCardViewController.dishLimit, reservation.restaurant.dishes.count)
        let endIndex = max(dishCount - 1, 0)
        let dishes = reservation.restaurant.dishes[0...endIndex]
        
        for dish in dishes {
            let dishViewController = DishViewController()
            addStackChildViewController(viewController: dishViewController, stackView:stackView)
            dishViewController.configure(dish: dish)
        }
        
    }

}

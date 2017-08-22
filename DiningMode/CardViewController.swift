//
//  CardViewController.swift
//  DiningMode
//
//  Created by Adrian Cheng on 8/21/17.
//  Copyright © 2017 OpenTable, Inc. All rights reserved.
//

import UIKit

protocol CardControllerProtocol {
    func configure(reservation: Reservation);
}

class CardViewController : UIViewController, CardControllerProtocol {
    var reservation : Reservation? = nil
    
    convenience init(reservation: Reservation) {
        self.init(nibName: nil, bundle: nil)
        
        self.reservation = reservation
    }
    
    // MARK: Boilerplate
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.didTapDone(sender:)))
        self.navigationItem.rightBarButtonItem = doneButton
        
        if let reservation = self.reservation {
            self.configure(reservation: reservation)
        }
    }
    
    // MARK: Navigation Bar Actions
    func didTapDone(sender: UIViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Navigation
    
    
    // MARK: CardControllerProtocol
    func configure(reservation: Reservation) {}
}

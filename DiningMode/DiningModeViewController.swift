//
//  DiningModeViewController.swift
//  DiningMode
//
//  Created by Adrian Cheng on 8/19/17.
//  Copyright © 2017 OpenTable, Inc. All rights reserved.
//

import UIKit

class DiningModeViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!
    
    var cardViewControllers : [CardViewController] = []
    var reservation : Reservation? = nil
    
    // MARK: Boilerplate
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Viewcontroller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.didTapCancel(sender:)))
        self.navigationItem.leftBarButtonItem = cancelButton

        fetchData { (reservation) in
            self.reservation = reservation
            self.loadCards(reservation: reservation)
        }
    }
    
    // MARK: Data fetch
    private func fetchData(completion: @escaping (Reservation) -> Void) {
        stackView.alpha = 0.0
        if let reservation = DataFetcher.fetchRandom() {
            // Delay to simulate data fetch over network
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.stackView.alpha = 1.0
                completion(reservation)
            }
        } else {
            // TODO: Just mark the view as red to show error for now
            view.backgroundColor = .red // Debug colors
        }
    }
    
    // MARK: View population
    private func loadCards(reservation: Reservation) {
        cardViewControllers = [FirstCardViewController(reservation: reservation), SecondCardViewController(reservation: reservation)]
        if reservation.restaurant.dishes.count > 0 {
            cardViewControllers.append(ThirdCardViewController(reservation: reservation))
        }
        
        for viewController in cardViewControllers {
            addStackChildViewController(viewController: viewController, stackView:stackView)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(gesture:)))
            viewController.view.addGestureRecognizer(tapGesture)
            viewController.view.tag = cardViewControllers.index(of: viewController)!
        }
    }
    
    // MARK: Gesture Handles
    func handleTapGesture(gesture: UITapGestureRecognizer) {
        
        if let view = gesture.view,
            let reservation = self.reservation {
            presentCardDetailController(tag: view.tag, reservation: reservation)
        }
    }
    
    // MARK: Presentation
    private func presentCardDetailController(tag: Int, reservation: Reservation) {
        if let cardViewController = DiningModeViewController.viewControllerForTag(index: tag, reservation: reservation) {
            
            let navigationController = UINavigationController(rootViewController: cardViewController)
            self.present(navigationController, animated: true, completion: nil)
            
        }
    }
    
    // MARK: Navigation Bar Actions
    func didTapCancel(sender: UIViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Private helpers
    static private func viewControllerForTag(index: Int, reservation: Reservation) -> CardViewController? {
        switch index {
        case 0:
            return FirstCardViewController(reservation: reservation)
        case 1:
            return SecondCardViewController(reservation: reservation)
        case 2:
            return ThirdCardViewController(reservation: reservation)
        default:
            break
        }
        
        return nil
    }
    
}

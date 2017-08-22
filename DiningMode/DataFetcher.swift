//
//  DataFetcher.swift
//  DiningMode
//
//  Created by Adrian Cheng on 8/21/17.
//  Copyright © 2017 OpenTable, Inc. All rights reserved.
//

import UIKit

class DataFetcher: NSObject {
    
    public static func fetchRandom() -> Reservation? {
        let resourceNames = ["PartialReservation", "FullReservation", "2dishes"]
        
        // DEBUG: choose to randomize or select your own data
//        let randomIndex = Int(arc4random_uniform(UInt32(resourceNames.count)))
//        let name = resourceNames[randomIndex]
        let name = resourceNames[1]
        return fetchReservation(resourceName: name)
    }
    
    public static func fetchReservation(resourceName: String) -> Reservation? {
        let url = Bundle.main.url(forResource: resourceName, withExtension:"json")
        let data = try! Data(contentsOf:url!, options: Data.ReadingOptions.uncached)
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
        
        guard let reservation = ReservationAssembler().createReservation(json) else {
            return nil
        }
        return reservation
    }
    
}

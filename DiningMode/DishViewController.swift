//
//  DishViewController.swift
//  DiningMode
//
//  Created by Adrian Cheng on 8/21/17.
//  Copyright © 2017 OpenTable, Inc. All rights reserved.
//

import UIKit
import AFNetworking

class DishViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    
    public func configure(dish: Dish) {
        titleLabel.text = dish.name
        
        if let urlText = dish.photos.first?.urlForSize(desiredSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) {
            if let url = URL(string: urlText) {
                imageView.setImageWith(url)
            }
        }
        
        let snippet = dish.snippet
        let content = snippet.content as NSString        
        let fullContent = content.substring(with: snippet.range)
        
        let attributedString = NSMutableAttributedString(string: fullContent)
        for range in snippet.highlights {
            let subRange = NSMakeRange(range.location - snippet.range.location, range.length)
            attributedString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 20.0), range: subRange)
        }
        label.attributedText = attributedString

    }

}

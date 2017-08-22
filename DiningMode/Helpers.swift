//
//  Helpers.swift
//  DiningMode
//
//  Created by Adrian Cheng on 8/21/17.
//  Copyright © 2017 OpenTable, Inc. All rights reserved.
//

import UIKit

class CustomDateFormatters {
    public static let humanReadableFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy, h:mm a"
        return formatter
    }()
}

extension UIViewController {
    func addStackChildViewController(viewController: UIViewController, stackView: UIStackView) {
        addChildViewController(viewController)
        stackView.addArrangedSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
    }
}

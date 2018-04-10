//
//  UIViewController+Alerts.swift
//  ChannelsCodingChallenge
//
//  Created by Vamsi Chebolu on 4/9/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import UIKit

/* Extension to keep default alert logic. */
extension UIViewController {
    static func alertController(for message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        return alert
    }
}

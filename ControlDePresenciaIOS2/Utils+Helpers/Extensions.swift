//
//  Extensions.swift
//  ControlDePresenciaIOS2
//
//  Created by Aide Alvarado on 2/5/22.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadedFrom(link:String, contentMode mode: UIView.ContentMode = .scaleAspectFit ) {
  //
    }
    
}
// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

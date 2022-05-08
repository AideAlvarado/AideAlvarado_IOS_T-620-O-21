//
//  Styles.swift
//  ControlDePresenciaIOS2
//
//  Created by Aide Alvarado on 6/5/22.
//

import Foundation
import UIKit
struct Theme {
    static var backgroundColor: UIColor?
    static var buttonTextColor: UIColor?
    static var buttonBackgroundColor: UIColor?
    
    static public func defaultTheme(){
        self.backgroundColor = UIColor.systemTeal
        self.buttonTextColor = UIColor.blue
        self.buttonBackgroundColor = UIColor.white
        updateDisplay()
        
    }
    static public func darkTheme(){
        self.backgroundColor = UIColor.darkGray
        self.buttonTextColor = UIColor.white
        self.buttonBackgroundColor = UIColor.black
        updateDisplay()
        
    }
    
    static public func updateDisplay(){
        let proxyButton = UIButton.appearance()
        proxyButton.setTitleColor(Theme.buttonTextColor, for: .normal)
        
        proxyButton.backgroundColor = Theme.backgroundColor
        let proxyView = UIView.appearance()
        proxyView.backgroundColor = backgroundColor
        UIBarButtonItem.appearance().customView?.backgroundColor = backgroundColor
        UITextField.appearance().backgroundColor = UIColor.white
        UITextField.appearance().textColor = UIColor.black

        
    }
}

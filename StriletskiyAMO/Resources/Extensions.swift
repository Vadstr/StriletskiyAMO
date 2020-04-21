//
//  Extensions.swift
//  StriletskiyAMO
//
//  Created by Денис Данилюк on 15.03.2020.
//  Copyright © 2020 com.Vadim. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension UIView {
    class var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController {
    
    class var identifier: String {
        return String(describing: self)
    }
    
}


extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}

// MARK: - FormattingExtension

/// HOW TO CALL
/// cell.deltaNLabel.attributedText = YOURDOUBLENUMBER.scientificFormatted

extension Formatter {
    static let scientific: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        
        formatter.positiveFormat = "0.###E+0"
        formatter.exponentSymbol = "*10^"
        
        return formatter
    }()
}


extension Numeric {
    var scientificFormatted: NSMutableAttributedString {
        let stringFromFormatter = Formatter.scientific.string(for: self) ?? ""
        
        /// ["4.267*10", "-1"] example of  `splitedString`
        let splitedString = stringFromFormatter.split(separator: "^")

        let result = NSMutableAttributedString()

        guard let font: UIFont = UIFont(name: "Helvetica", size:18) else { return NSMutableAttributedString() }
        guard let fontUpper: UIFont = UIFont(name: "Helvetica", size:12) else { return NSMutableAttributedString() }
        
        if stringFromFormatter == "NaN" || stringFromFormatter == "+∞" || stringFromFormatter == "-∞" {
            return NSMutableAttributedString(string: String(splitedString[0]), attributes: [.font: font])
        } else {
            let attributedPart1: NSMutableAttributedString = NSMutableAttributedString(string: String(splitedString[0]), attributes: [.font: font])
            let attributedPart2: NSMutableAttributedString = NSMutableAttributedString(string: String(splitedString[1]), attributes: [.font: fontUpper,.baselineOffset:10])

            result.append(attributedPart1)
            result.append(attributedPart2)

            return result
        }
        
    }
}

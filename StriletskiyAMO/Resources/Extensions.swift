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
    
//    func setupButton() {
//        let button = UIBarButtonItem(image: UIImage.init(systemName: "square.stack.3d.up"), style: .plain, target: self, action: #selector(show(sender:)))
//        navigationItem.leftBarButtonItem = button
//    }
//
//    @objc func show(sender: UIBarButtonItem) {
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        guard let vc : LabChooserViewController = mainStoryboard.instantiateViewController(withIdentifier: LabChooserViewController.identifier) as? LabChooserViewController else { return }
//        present(vc, animated: true, completion: nil)
//    }
}


extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}

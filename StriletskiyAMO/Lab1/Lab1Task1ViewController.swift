//
//  Lab1Task1ViewController.swift
//  StriletskiyAMO
//
//  Created by Денис Данилюк on 15.03.2020.
//  Copyright © 2020 com.Vadim. All rights reserved.
//

import UIKit

class Lab1Task1ViewController: UIViewController {

    
    @IBOutlet weak var xTextField: UITextField!
    
    @IBOutlet weak var aTextField: UITextField!
    
    @IBOutlet weak var bTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dismissKeyboard()
    }
    
    @IBAction func didPressGetResult(_ sender: UIButton) {
        
        
        let x = Double(xTextField.text ?? "") ?? 0.0
        
      
        
        resultLabel.text = "\(x)"
        
    }
    
    

}

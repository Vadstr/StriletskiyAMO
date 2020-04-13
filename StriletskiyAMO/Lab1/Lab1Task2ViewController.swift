//
//  Lab1Task2ViewController.swift
//  StriletskiyAMO
//
//  Created by Vadim on 16.03.2020.
//  Copyright © 2020 com.Vadim. All rights reserved.
//

import UIKit

class Lab1Task2ViewController: UIViewController {
    
    @IBOutlet weak var rTextField: UITextField!
    
    @IBOutlet weak var cTextField: UITextField!
    
    @IBOutlet weak var bTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
           super.viewDidLoad()

        hideKeyboard()
        setupButton()
        }
              
      func setupButton() {
          let button = UIBarButtonItem(image: UIImage.init(systemName: "square.stack.3d.up"), style: .plain, target: self, action: #selector(show(sender:)))
          navigationItem.rightBarButtonItem = button
      }

      @objc func show(sender: UIBarButtonItem) {
          let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
          guard let vc : GraphViewController = mainStoryboard.instantiateViewController(withIdentifier: GraphViewController.identifier) as? GraphViewController else { return }
          vc.image = UIImage(named:"lab1task2graf")
          present(vc, animated: true, completion: nil)
      }
       
       @IBAction func didPressGetResult(_ sender: UIButton) {
           
           
           let r = Double(rTextField.text ?? "") ?? 0.0

           let c = Double(cTextField.text ?? "") ?? 0.0

           let b = Double(bTextField.text ?? "") ?? 0.0
        
           var result = 0.0
        
           if r < 0 {
               result = (pow(Double(c),2) + pow(Double(b),2))/(Double.pi * pow(Double(r),2))
           } else {
               result = Double.pi * pow(Double(r),2) / (2*Double.pi * r + 21 * r)
           }
          


           
           resultLabel.text = "Результат: \(result)"
           
       }
}

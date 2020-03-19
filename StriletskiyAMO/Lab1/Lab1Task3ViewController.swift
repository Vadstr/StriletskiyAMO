//
//  Lab1Task3ViewController.swift
//  StriletskiyAMO
//
//  Created by Vadim on 16.03.2020.
//  Copyright © 2020 com.Vadim. All rights reserved.
//

import UIKit

class Lab1Task3ViewController: UIViewController {

    @IBOutlet weak var aTextField: UITextField!
    
    @IBOutlet weak var bTextField: UITextField!
    
    @IBOutlet weak var nTextField: UITextField!
    
    @IBOutlet weak var pTextField: UITextField!
    
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
          vc.image = UIImage(named:"lab1task3")
          present(vc, animated: true, completion: nil)
      }
       
       @IBAction func didPressGetResult(_ sender: UIButton) {
           
           
           let a = Double(aTextField.text ?? "") ?? 0.0

           let b = Double(bTextField.text ?? "") ?? 0.0

           let n = Double(nTextField.text ?? "") ?? 0.0
           
           let p = Double(pTextField.text ?? "") ?? 0.0

           let result = sin(a/b)+pow(Double(sin(a/b)),2)+cos(pow(Double(n),2))+cos(sqrt(p))


           
           resultLabel.text = "Результат: \(result)"
           
       }
}

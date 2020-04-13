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
          vc.image = UIImage(named:"lab1task3graf")
          present(vc, animated: true, completion: nil)
      }
       
       @IBAction func didPressGetResult(_ sender: UIButton) {


            let splitedA = (aTextField.text ?? "").split(separator: ",")

            var arrayA: [Double] = []

            for part in splitedA {
            let trimmed = String(part).trimmingCharacters(in: .whitespacesAndNewlines)
            arrayA.append(Double(trimmed) ?? 0.0)
            }

            let splitedB = (bTextField.text ?? "").split(separator: ",")

            var arrayB: [Double] = []

            for part in splitedB {
            let trimmed = String(part).trimmingCharacters(in: .whitespacesAndNewlines)
            arrayB.append(Double(trimmed) ?? 0.0)
            }
        
        var f = 0.0
        for i in 0..<arrayA.count {
            for j in 0..<arrayB.count {
                f += arrayA[i] + arrayB[j]
                }
            }
        
        var s  = 1.0
        for i in 0..<arrayA.count {
            s *= arrayA[i]
        }
        
        var t  = 0.0
        for j in 0..<arrayB.count {
            t += arrayB[j]
        }
        
        
        let result = ( s + t ) / f



            resultLabel.text = "Результат: \(result)"

       }
}

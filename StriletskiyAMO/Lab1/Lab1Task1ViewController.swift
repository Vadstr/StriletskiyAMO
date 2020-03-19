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
        vc.image = UIImage(named:"lab1task1")
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func didPressGetResult(_ sender: UIButton) {
        
        
        let x = Double(xTextField.text ?? "") ?? 0.0

        let a = Double(aTextField.text ?? "") ?? 0.0

        let b = Double(bTextField.text ?? "") ?? 0.0

        let result = sin(a/b)+pow(Double(sin(a/b)),2)+cos(pow(Double(x),2))+cos(sqrt(x))


        
        resultLabel.text = "Результат: \(result)"
        
    }
}

//
//  Lab4ViewController.swift
//  StriletskiyAMO
//
//  Created by Головаш Анастасия on 21.04.2020.
//  Copyright © 2020 com.Vadim. All rights reserved.
//

import UIKit

class Lab4ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var separatedRootsLabel: UILabel!
    @IBOutlet weak var separatedRootsAnsLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var xStackView: UIStackView!
    @IBOutlet weak var yStackView: UIStackView!
    @IBOutlet weak var resView1: UIView!
    @IBOutlet weak var resView2: UIView!
    @IBOutlet weak var resView3: UIView!
    
    @IBOutlet weak var aTextFied: UITextField!
    @IBOutlet weak var bTextFied: UITextField!
    @IBOutlet weak var accuracyTextField: UITextField!
    
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aTextFied.delegate = self
        bTextFied.delegate = self
        accuracyTextField.delegate = self
        
        separatedRootsLabel.text = ""
        
        resultLabel.isHidden = true
        xStackView.isHidden = true
        yStackView.isHidden = true
        
        resView1.isHidden = false
        resView2.isHidden = false
        resView3.isHidden = false

        hideKeyboard()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        aTextFied.resignFirstResponder()
        bTextFied.resignFirstResponder()
        accuracyTextField.resignFirstResponder()
        return true
    }
    // Знаходить значення функції
    func findY(_ x: Double) -> Double {
        return 1.8 * pow(x, 2) - sin(10 * x)
    }
    // Знаходить значення похідної в точці
    func dfDx(_ x: Double) -> Double {
        return 18 / 5 * x - 10 * cos(10 * x)
    }
    // Знаходить значення другої похідної в точці
    func ddfDx(_ x: Double) -> Double {
        return 18 / 5 + 100 * sin(10 * x)
    }
    // Комбінованим методом знаходить наближено корінь функції на проміжку [a, b]
    func combinedMethod(initiallyA: Double, initiallyB: Double, accuracy: Double) -> Double {
        var a = initiallyA
        var b = initiallyB
        
        if findY(a) * findY(b) < 0 {
            if dfDx(a) * ddfDx(a) > 0 {
                let z = a
                a = b
                b = z
            }
            repeat {
                a -= (findY(a) * (b - a)) / (findY(b) - findY(a))
                b -= (findY(b) / dfDx(b))
            } while abs(b - a) > accuracy
            
            return (b + a) / 2
        
        } else {
            let alert = UIAlertController(title: "", message: "Для даного проміжка розв'язку немає!", preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
            print ("Розв'язку немає!")
            alert.addAction(okBtn)
            present(alert, animated: true, completion: nil)
            return 0.0
        }
    }
    // Відокремлює корені рівняння
    func separationOfRoots() -> [[Double]] {
        var resultArr: [[Double]] = []
        for i in stride(from: -1.0, to: 1.0, by: 0.1) {
            if (findY(i) * findY(i + 0.1) < 0) && (dfDx(i) * dfDx(i + 0.1) > 0) {
                resultArr.append([i.rounded(digits: 1), (i + 0.1).rounded(digits: 1)])
            }
        }
        return resultArr
    }

    @IBAction func didPressShowseparatedRootsButton(_ sender: UIButton) {
        separatedRootsAnsLabel.text = separationOfRoots().description
        separatedRootsLabel.text = "Відокремлені корені:"
        separatedRootsAnsLabel.isHidden = false
    }
    
    @IBAction func didPressResultButton(_ sender: UIButton) {
        let x = combinedMethod(initiallyA: Double(aTextFied.text ?? "0") ?? 0.0, initiallyB: Double(bTextFied.text ?? "0") ?? 0.0,  accuracy: Double(accuracyTextField.text ?? "0") ?? 0.0)
        let y = findY(x)
        
        xLabel.text = String(x)
        yLabel.text = String(y)
        
        resultLabel.isHidden = false
        xStackView.isHidden = false
        yStackView.isHidden = false
        
        resView1.isHidden = true
        resView2.isHidden = true
        resView3.isHidden = true
        
    }
    
}


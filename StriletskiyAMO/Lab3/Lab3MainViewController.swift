//
//  Lab3ViewController.swift
//  StriletskiyAMO
//
//  Created by Головаш Анастасия on 18.04.2020.
//  Copyright © 2020 com.Vadim. All rights reserved.
//

import UIKit
import Charts

class Lab3MainViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var changeFormulaButton: UIButton!
    @IBOutlet weak var changeFormulaLabel: UILabel!
    @IBOutlet weak var nTextField: UITextField!
    @IBOutlet weak var xTextField: UITextField!
    
    var isMyVariantFunc = true
    var n = 10
    var x = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nTextField.delegate = self
        xTextField.delegate = self
        
        self.title = "Схема Ейткена"
        changeFormulaButton.setTitle("Змінити на sin(x)", for: .normal)
        changeFormulaLabel.text = "sin(x)^3 + 3cos(x)^2"
        isMyVariantFunc = true
      
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        xTextField.resignFirstResponder()
        nTextField.resignFirstResponder()
        return true
    }
    
    
    func findPointsForInterpolation(degree : Int) -> (x: [Double], y: [Double]){
        let a = 0.0
        let b = 4.0
        let h: Double = Double((b - a) / Double(degree))
        var x: [Double] = []
        var y: [Double] = []
        
        if isMyVariantFunc {
            for i in 0...degree {
                x.append(Double(a) + h * Double(i))
                y.append(pow(sin(x[i]), 3) + (3 * pow(cos(x[i]), 2)))
            }
        } else {
            for i in 0...degree {
                x.append(Double(a) + h * Double(i))
                y.append(sin(x[i]))
            }
        }
        return (x, y)
    }

    
    func yValue(x: Double) -> Double {
        if isMyVariantFunc {
            return pow(sin(x), 3) + (3 * pow(cos(x), 2))
        } else {
            return sin(x)
        }
    }
    
    
    func differArr(_ a: [Double], _ b: [Double]) -> [Double] {
        var result: [Double] = []
        for i in 0..<a.count {
            result.append(a[i] - b[i])
        }
        return result
    }
    
    
    func schemeOfAitken(xArr: [Double], yArr: [Double], x: Double) -> Double {
        let n = xArr.count
        var p: [Double] = []
        for _ in 0..<n {
            p.append(contentsOf: [0])
        }
        
        for k in 0..<n {
            let some = n - k
            for i in 0..<some {
                if k == 0 {
                    p[i] = yArr[i]
                } else {
                    p[i] = ((x-xArr[i+k])*p[i]+(xArr[i]-x)*p[i+1])/(xArr[i]-xArr[i+k])
                }
            }
        }
        return p[0]
    }
    
    
    func aitkenValuesArr(xArr: [Double], numberOfValues: Int) -> [Double] {
        let pointsArr = findPointsForInterpolation(degree: numberOfValues)
        var aitkenValuesArray: [Double] = []
        for i in xArr {
            aitkenValuesArray.append(schemeOfAitken(xArr: pointsArr.x, yArr: pointsArr.y, x: i))
        }
        return aitkenValuesArray
    }
    
  
    func errorEstimationValues(n: Int, x: Double) -> ([Double], [Double], [Double]) {
        let yFormulaValues = yValue(x: x)
        var xInterArr: [Double] = []
        var differArr: [Double] = []
        var errorArr: [Double] = []
        var kArr: [Double] = []
        for n in 1...n + 1 {
            let (valuesX, valuesY) = findPointsForInterpolation(degree: n)
            xInterArr.append(schemeOfAitken(xArr: valuesX, yArr: valuesY, x: x))
            differArr.append(xInterArr[n - 1] - yFormulaValues)
            if n > 1 {
                errorArr.append(xInterArr[n - 2] - xInterArr[n - 1])
                kArr.append(1 - differArr[n - 2] / errorArr[n - 2])
            }
        }
        return (errorArr, differArr, kArr)
    }
    
    
    func prepareChartData(xArr: [Double], yArr: [Double]) -> [ChartDataEntry] {
        var values: [ChartDataEntry] = []
        for i in 0..<xArr.count {
            if !yArr[i].isInfinite {
                let charData = ChartDataEntry(x: xArr[i], y: yArr[i])
                values.append(charData)
            }
        }
        return values
    }
    
    
    @IBAction func didPressChangeFormulaButton(_ sender: UIButton) {
        if isMyVariantFunc {
            changeFormulaButton.setTitle("Змінити на sin(x)^3 + 3cos(x)^2", for: .normal)
            changeFormulaLabel.text = "sin(x)"
            isMyVariantFunc = false
        } else {
            changeFormulaButton.setTitle("Змінити на sin(x)", for: .normal)
            changeFormulaLabel.text = "sin(x)^3 + 3cos(x)^2"
            isMyVariantFunc = true
        }
    }
    
    
    @IBAction func didPressResultButton(_ sender: UIButton) {
        n = Int(nTextField.text ?? "10") ?? 10
        x = Double(xTextField.text ?? "1") ?? 1.0
        guard let x = Double(xTextField.text ?? "0.5") else { return }
        
        let y = aitkenValuesArr(xArr: [x], numberOfValues: n)[0]
        let y1 = aitkenValuesArr(xArr: [x], numberOfValues: n + 1)[0]
        let y2 = aitkenValuesArr(xArr: [x], numberOfValues: n + 2)[0]
        let error = y - y1
        let errorOfError = y1 - y2
        let errorBlur = abs(errorOfError / error)
        let errorArr = errorEstimationValues(n: n, x: x).0
        let differArr = errorEstimationValues(n: n, x: x).1
        let kArr = errorEstimationValues(n: n, x: x).2
        var numbers: [Int] = []
        for i in 1...n {
            numbers.append(i)
        }
        
        guard let tableVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Lab3TableViewController") as? Lab3TableViewController else { return }
                    
                DispatchQueue.main.async {
                    
                    tableVC.y = y
                    tableVC.error = error
                    tableVC.errorOfError = errorOfError
                    tableVC.errorBlur = errorBlur
                    tableVC.numbers = numbers
                    tableVC.interpolationError = errorArr
                    tableVC.interpolatedAndExactDifference = differArr
                    tableVC.refinementCoefficient = kArr
                    tableVC.x = x

                    self.navigationController?.pushViewController(tableVC, animated: true)
                }
    }
    
    
    @IBAction func didPressGraphOfError(_ sender: UIButton) {
        n = Int(nTextField.text ?? "10") ?? 10
        
        let chartValuesXY = findPointsForInterpolation(degree: 1000)
        let interpolationYArray = aitkenValuesArr(xArr: chartValuesXY.x, numberOfValues: n)
        let interpolationErrorYArray = aitkenValuesArr(xArr: chartValuesXY.x, numberOfValues: n + 1)
        let estimationOfInterpolationError = differArr(interpolationYArray, interpolationErrorYArray).map { -1 * log10(abs($0)) }
        let valuesMistake = prepareChartData(xArr: chartValuesXY.x, yArr: estimationOfInterpolationError)
            
        guard let chartVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Lab3ChartViewController") as? Lab3ChartViewController else { return }
                
            DispatchQueue.main.async {
                
                chartVC.valuesSegueMistake = valuesMistake
                chartVC.variantFuncsion = self.isMyVariantFunc
                chartVC.isShowFunc = false

                self.navigationController?.pushViewController(chartVC, animated: true)
            }
    }
    
    
    @IBAction func didPressFunctionGraph(_ sender: UIButton) {
        n = Int(nTextField.text ?? "10") ?? 10
        
        let chartValuesXY = findPointsForInterpolation(degree: 1000)
        let interpolationYArray = aitkenValuesArr(xArr: chartValuesXY.x, numberOfValues: n)
        let values = prepareChartData(xArr: chartValuesXY.x, yArr: chartValuesXY.y)
        let values2 = prepareChartData(xArr: chartValuesXY.x, yArr: interpolationYArray)

        guard let chartVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Lab3ChartViewController") as? Lab3ChartViewController else { return }
                
            DispatchQueue.main.async {
                
                chartVC.valuesSegue = values
                chartVC.valuesSegue2 = values2
                chartVC.variantFuncsion = self.isMyVariantFunc
                chartVC.isShowFunc = true

                self.navigationController?.pushViewController(chartVC, animated: true)
            }
    }

}

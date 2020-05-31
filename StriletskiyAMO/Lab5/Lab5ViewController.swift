//
//  Lab5ViewController.swift
//  StriletskiyAMO
//
//  Created by Vadim on 29.05.2020.
//  Copyright © 2020 com.Vadim. All rights reserved.
//

import UIKit

class Lab5ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var epsilonTextField: UITextField!
    
    private let picker = UIPickerView()
    private let pickerData = ["2", "3", "4"]
    
    var matrixATextFields: [[UITextField]] = []
    var matrixBTextFields: [UITextField] = []
    
    var size4Array: [UIView] = []
    var size3Array: [UIView] = []
    
    var lables3: [UILabel] = []
    var lables2: [UILabel] = []
    
    var matrixA: [[Double]] = []
    var matrixB: [Double] = []
    
    var size: Int = 3
    var epsilon: Double = 0.01
    var textResult: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Метод верхньої релаксації"
        createTextFieldsArrays()
        setupPicker()
        createSizeArrays()
        matrixSise4(isHiden: true)
        
    }
    
    
    // MARK: - Picker funcs
        
    private func setupPicker() {
        picker.delegate = self
        picker.dataSource = self
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: true)
       
        sizeTextField.inputView = picker
        sizeTextField.inputAccessoryView = toolbar
        picker.selectRow(1, inComponent: 0, animated: true)
        sizeTextField.text = pickerData[1]
    }
    
    @objc func doneAction() {
        view.endEditing(true)
    }

    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sizeTextField.resignFirstResponder()
        return true
    }
    
    /// Створює масиви з TextFields для введеня матриць
    func createTextFieldsArrays() {
        var matrixTextField = UITextField()
        for i in 1...4 {
            matrixATextFields.append([])
            for j in 1...4 {
                matrixTextField = view.viewWithTag(i * 10 + j) as! UITextField
                matrixATextFields[i - 1].append(matrixTextField)
            }
            matrixTextField = view.viewWithTag(i * 10 + 5) as! UITextField
            matrixBTextFields.append(matrixTextField)
        }
    }

    /// Створює масив зUIViews і UILabels для відображення матриць різних розмірів
    func createSizeArrays() {
        var myview = UIView()
        var stack = UIStackView()
        
        stack = view.viewWithTag(400) as! UIStackView
        size4Array.append(stack)
        for i in 1...3 {
            myview = view.viewWithTag(400 + i)!
            size4Array.append(myview)
        }
        stack = view.viewWithTag(300) as! UIStackView
        size3Array.append(stack)
        for i in 1...2 {
            myview = view.viewWithTag(300 + i)!
            size3Array.append(myview)
        }
        
        for i in 1...3 {
            guard let label = view.viewWithTag(300 + i * 10 + 3) as? UILabel else { return }
            lables3.append(label)
        }
        for i in 1...2 {
            guard let label = view.viewWithTag(200 + i * 10 + 2) as? UILabel else { return }
            lables2.append(label)
        }
    }

    /// Ховає або показує 4 стовпець та рядок
    func matrixSise4(isHiden: Bool) {
        for view in size4Array {
            view.isHidden = isHiden
        }
        for label in lables3 {
            if isHiden {
                label.text = "x3="
            } else {
                label.text = "x3+"
            }
        }
    }
    
    /// Ховає або показує 3 стовпець та рядок
    func matrixSize3(isHiden: Bool) {
        for view in size3Array {
            view.isHidden = isHiden
        }
        for label in lables2 {
            if isHiden {
                label.text = "x2="
            } else {
                label.text = "x2+"
            }
        }
    }
    
    /// Функція для відображення матриць різних розмірів залежно від заданого розміру
    func matrixView(size: Int) {
        if size < 4 {
            matrixSise4(isHiden: true)
            if size < 3 {
                matrixSize3(isHiden: true)
            }
        }
        if size > 2 {
            matrixSize3(isHiden: false)
            if size > 3 {
               matrixSise4(isHiden: false)
            }
        }
    }
    
    
    // MARK: - method of upper relaxation
    
    /// Вивід матриці
    func printMatrix(matrix: [[Double]], roots: [Double]) {
        var stringMatrixToPrint: [String] = []
        var rootsToPrint = roots
        let multiplier = pow(10.0, Double(4))

        for i in 0..<matrix.count {
            let row = matrix[i]
            var line = ""
            for j in 0..<row.count {
                if j < row.count - 1 {
                    line.append(contentsOf: "\(((matrix[i][j]) * multiplier).rounded() / multiplier)x\(j + 1)+")
                } else {
                    line.append(contentsOf: "\(((matrix[i][j]) * multiplier).rounded() / multiplier)x\(j + 1)")
                }
            }
            stringMatrixToPrint.append(line)
            rootsToPrint[i] = (rootsToPrint[i] * multiplier).rounded() / multiplier
        }
        
        for rowNumber in 0..<matrix.count {
            textResult.append(contentsOf: "\n\(stringMatrixToPrint[rowNumber]) = \(rootsToPrint[rowNumber])")
        }
    }

    /// Додає елементи масиву
    func sum(_ array: [Double]) -> Double {
        var sum: Double = 0
        for element in array {
            sum += element
        }
        return sum
    }

    /// Перевірка чи є дана матриця з головною домінуючою діагоналлю
    func checkMatrix(matrix: [[Double]]) -> Bool {
        var check = true
        
        for rowNumber in 0..<matrix.count {
            let row = matrix[rowNumber]
            var sum = 0.0
            
            for elementNumber in 0..<row.count {
                if elementNumber != rowNumber {
                    sum += abs(matrix[rowNumber][elementNumber])
                }
            }
            if abs(row[rowNumber]) < abs(sum) {
                check = false
            }
        }
        return check
    }

    /// Реалізиція алгоритму верхньої релаксації
    func upperRelaxation(matrix: [[Double]], oldNevyzky: [Double], iterationNumber: Int, epsilon: Double) -> (nevyzky: [Double], iterationNumber: Int) {
        var result: [Double] = oldNevyzky
        let resultIterationNumber = iterationNumber + 1
        var diferArray: [Double] = []
        
        // Коефіціент релаксації
        let w: Double = 1
        
        for i in 0..<matrix.count {
            result[i] = (matrix[i][0] + matrix[i][1] * result[1] + matrix[i][2] * result[2])
            
            result[i] = oldNevyzky[i] + w * (result[i] - oldNevyzky[i])
            diferArray.append(abs(oldNevyzky[i] - result[i]))
        }
        
        if diferArray.max() ?? 0 > epsilon {
            return upperRelaxation(matrix: matrix, oldNevyzky: result, iterationNumber: resultIterationNumber, epsilon: epsilon)
        } else {
            return (nevyzky: result, iterationNumber: resultIterationNumber)
        }
    }

    /// Створення масивів в залежності від варіанту
    func prepareMatrix(isMyVariant: Bool) {
        textResult = ""
        epsilon = Double(epsilonTextField.text ?? "0.01") ?? 0.01
        
        if !isMyVariant {
            matrixA = []
            matrixB = []
            
            for i in 1...size {
                matrixA.append([])
                for j in 1...size {
                    guard let stringElement = matrixATextFields[i - 1][j - 1].text else { return }
                    let elem = Double(stringElement) ?? 0.0
                    matrixA[i - 1].append(elem)
                }
                guard let stringElement = matrixBTextFields[i - 1].text else { return }
                let elem = Double(stringElement) ?? 0.0
                matrixB.append(elem)
            }
        } else {
            matrixA = [[4, 2, -1],
                        [5, 3, -2],
                        [3, 2, -3]]
            matrixB = [-1, 2, 0]
        }
        
        textResult.append(contentsOf: "Початкова матриця:\n")
        printMatrix(matrix: matrixA, roots: matrixB)
    }

    /// Перетворена до матриці з домінуючою діагоналлю матриця за варіантом
    func matrixTransformation() {
        matrixA = [[0.99885, -0.00138, -0.00105],
                    [-0.00038, 0.99828, -0.0013],
                    [-0.00013, -0.00088, 0.99945]]
        matrixB = [-1.00074, 2.99971, 0.999604]
        
        textResult.append(contentsOf: "\n\nПеретворена матриця:\n")
        printMatrix(matrix: matrixA, roots: matrixB)
        textResult.append(contentsOf: "\n\nДана матриця з домінуючою головною діагоналлю")
        solvingTheSystem()
    }
    
    /// Хід розв'язку з початковими перетвореннями і підготовкою матриці
    func solvingTheSystem() {
        // Нова матриця готова до алгоритму
        var readyMatrix: [[Double]] = []

        for i in 0..<matrixA.count {
            
            var row = matrixA[i]

            let divider = row.remove(at: i)
            
            for j in 0..<row.count {
                row[j] = row[j] / -divider
            }
            
            row.insert(matrixB[i] / divider, at: 0)

            readyMatrix.append(row)
        }

        // Початкові невязки
        var nevazky: [Double] = [readyMatrix[0][0]]
        while nevazky.count < size {
            nevazky.append(0)
        }

        textResult.append(contentsOf: "\n\nМатриця підготовлена до методу верхньої релаксації:\n")
        printMatrix(matrix: readyMatrix, roots: Array(repeating: 0.0, count: readyMatrix.count))

        let result = upperRelaxation(matrix: readyMatrix, oldNevyzky: nevazky, iterationNumber: 0, epsilon: epsilon)
        textResult.append(contentsOf: "\n\nРезультат:")
        for i in 1...result.nevyzky.count {
            textResult.append(contentsOf: "\nx\(i) = \(result.nevyzky[i - 1])")
        }

        textResult.append(contentsOf: "\n\nКількість ітерацій: \(result.iterationNumber)")
        
    }

    /// Юзер натиснув розв'язати довільну матрицю
    @IBAction func didPressSolve(_ sender: UIButton) {
        
        prepareMatrix(isMyVariant: false)

        // Перевірка на домінуючу діагональ
        if checkMatrix(matrix: matrixA) {
            textResult.append(contentsOf: "\n\nДана матриця з домінуючою головною діагоналлю")
            solvingTheSystem()
        } else {
            textResult.append(contentsOf: "\n\nДана матриця НЕ з домінуючою головною діагоналлю")
        }
        
        guard let resultVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Lab5ResultViewController") as? Lab5ResultViewController else { return }
        resultVC.bigText = textResult
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
    
    /// Юзер натиснув розв'язати матрицю за варіантом
    @IBAction func didPressSolveMyVariant(_ sender: UIButton) {
        
        prepareMatrix(isMyVariant: true)

        // Перевірка на домінуючу діагональ
        if checkMatrix(matrix: matrixA) {
            textResult.append(contentsOf: "\n\nДана матриця з домінуючою головною діагоналлю")
            solvingTheSystem()
        } else {
            textResult.append(contentsOf: "\n\nДана матриця НЕ з домінуючою головною діагоналлю")
            matrixTransformation()
        }
        
        guard let resultVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Lab5ResultViewController") as? Lab5ResultViewController else { return }
        resultVC.bigText = textResult
        resultVC.myTitle = "Система задана за варіантом"
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
    
        

}


// MARK: -  UIPickerViewDelegate, UIPickerViewDataSource

extension Lab5ViewController:  UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sizeTextField.text = pickerData[row]
        matrixView(size: Int(pickerData[row]) ?? 3)
        size = Int(pickerData[row]) ?? 3
    }
}

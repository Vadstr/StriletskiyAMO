//
//  Lab2ViewController.swift
//  StriletskiyAMO
//
//  Created by Vadim on 10.04.2020.
//  Copyright © 2020 com.Vadim. All rights reserved.
//

import UIKit

class Lab2ViewController: UIViewController {

    @IBOutlet weak var arrayB: UITextField!

    @IBOutlet weak var notsortedLabel: UILabel!
    @IBOutlet weak var sortedLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ressultButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboard()
    }
    
    @IBAction func didPressGetResult(_ sender: UIButton) {
        var arrayA: [Double] = []
        var sorted: [Double] = []
        
        
        let splited = (arrayB.text ?? "").split(separator: ",")
        for part in splited {
            let trimmed = String(part).trimmingCharacters(in: .whitespacesAndNewlines)
            arrayA.append(Double(trimmed) ?? 0.0)
        }
        
        
        let start = Date()
        sorted = sortArray(arrayA)
        let end = Date()
        let timeInterval: Double = end.timeIntervalSince(start)

        
        sortedLabel.text = "Відстортований [В] = \(sorted.description)"
        notsortedLabel.text = "Початковий [В] = \(arrayA.description)"
        timeLabel.text = "Елементів: \(arrayA.count)\nЧас: \(timeInterval.rounded(digits: 6))"
        
    }
    
    func sortArray(_ startArray: [Double]) -> [Double] {
        
        if startArray.count <= 1 {
            return startArray
        }
        let arraySplited = startArray.split()
        print(arraySplited)
        let arrayFirst = sortArray(arraySplited[0])
        let arraySecond = sortArray(arraySplited[1])
 
        return merge(firstArray: arrayFirst, secondArray: arraySecond)
    }
    
    func merge( firstArray: [Double], secondArray: [Double]) -> [Double] {
        var sorted: [Double] = []
        var left_list_index = 0
        var right_list_index = 0
        let left_list_length = firstArray.count
        let right_list_length = secondArray.count
        
        for _ in 0..<(left_list_length + right_list_length) {
            if (left_list_index < left_list_length) && (right_list_index < right_list_length) {
                if firstArray[left_list_index] <= secondArray[right_list_index] {
                    sorted.append(firstArray[left_list_index])
                    left_list_index += 1
                } else {
                  sorted.append(secondArray[right_list_index])
                  right_list_index += 1
                }
            } else if left_list_index == left_list_length {
                sorted.append(secondArray[right_list_index])
                right_list_index += 1
            } else if right_list_index == right_list_length {
                sorted.append(firstArray[left_list_index])
                left_list_index += 1
            }
        }
        return sorted
    }

}
extension Array {
    func split() -> [[Element]] {
        let ct = self.count
        let half = ct / 2
        let leftSplit = self[0 ..< half]
        let rightSplit = self[half ..< ct]
        return [Array(leftSplit), Array(rightSplit)]
    }
}

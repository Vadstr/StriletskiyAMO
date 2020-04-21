//
//  Lab3TableViewController.swift
//  StriletskiyAMO
//
//  Created by Головаш Анастасия on 18.04.2020.
//  Copyright © 2020 com.Vadim. All rights reserved.
//

import UIKit

class Lab3TableViewController: UITableViewController {
    @IBOutlet weak var nLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorErooeLabel: UILabel!
    @IBOutlet weak var errorBlurLabel: UILabel!
    
    var numbers: [Int] = []
    var interpolationError: [Double] = []
    var interpolatedAndExactDifference: [Double] = []
    var refinementCoefficient: [Double] = []
    var y: Double?
    var error: Double?
    var errorOfError: Double?
    var errorBlur: Double?
    var x: Double = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Оцінка похибки для х = \(x)"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        nLabel.text = "Для n = \(numbers.count):"
        yLabel.attributedText = y?.scientificFormatted
        errorLabel.attributedText = error?.scientificFormatted
        errorErooeLabel.attributedText = errorOfError?.scientificFormatted
        errorBlurLabel.attributedText = errorBlur?.scientificFormatted
        
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count + 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Lab3TableViewCell", for: indexPath) as! Lab3TableViewCell

        if indexPath.row == 0 {
            cell.nLabel.text = "n"
            cell.errorLabel.text = "∆n"
            cell.differenceLabel.text = "∆exact n"
            cell.coefficientLabel.text = "k"
        } else {
            cell.nLabel.text = String(numbers[indexPath.row - 1])
            cell.errorLabel.attributedText = interpolationError[indexPath.row - 1].scientificFormatted
            cell.differenceLabel.attributedText = interpolatedAndExactDifference[indexPath.row - 1].scientificFormatted
            cell.coefficientLabel.attributedText = refinementCoefficient[indexPath.row - 1].scientificFormatted
        }
        return cell
    }
    

}

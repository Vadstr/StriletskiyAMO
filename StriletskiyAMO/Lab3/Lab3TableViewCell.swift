//
//  Lab3TableViewCell.swift
//  StriletskiyAMO
//
//  Created by Головаш Анастасия on 19.04.2020.
//  Copyright © 2020 com.Vadim. All rights reserved.
//

import UIKit

class Lab3TableViewCell: UITableViewCell {

    @IBOutlet weak var nLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var differenceLabel: UILabel!
    @IBOutlet weak var coefficientLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nLabel.text = nil
        errorLabel.text = nil
        differenceLabel.text = nil
        coefficientLabel.text = nil 
    }

}

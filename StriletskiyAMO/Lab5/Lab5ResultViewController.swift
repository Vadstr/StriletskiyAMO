//
//  Lab5ResultViewController.swift
//  StriletskiyAMO
//
//  Created by Головаш Анастасия on 31.05.2020.
//  Copyright © 2020 com.Vadim. All rights reserved.
//

import UIKit

class Lab5ResultViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    public var bigText = ""
    public var myTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = bigText
        self.title = myTitle
    }
    
}

//
//  GraphViewController.swift
//  StriletskiyAMO
//
//  Created by Vadim on 16.03.2020.
//  Copyright © 2020 com.Vadim. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let image = image else { return }
        imageView.image = image

        // Do any additional setup after loading the view.
    }
}

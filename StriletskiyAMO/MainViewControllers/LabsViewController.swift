//
//  LabsViewController.swift
//  StriletskiyAMO
//
//  Created by Денис Данилюк on 15.03.2020.
//  Copyright © 2020 com.Vadim. All rights reserved.
//

import UIKit

class LabsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    

}

extension LabsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "reuseID")
        
        let array = ["Лабораторна 1", "Лабораторна 2", "Лабораторна 3", "Лабораторна 4", "Лабораторна 5"]
        
        cell.textLabel?.text = array[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTasks" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let destination = segue.destination as? TasksViewController {
                    destination.labChoosen = indexPath.row + 1
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showTasks", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

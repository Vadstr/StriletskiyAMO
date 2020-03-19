//
//  TasksViewController.swift
//  StriletskiyAMO
//
//  Created by Денис Данилюк on 15.03.2020.
//  Copyright © 2020 com.Vadim. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    
    var labChoosen = 0
    var labCount = [3, 1, 1, 1, 1]

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    


}
extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labCount[labChoosen - 1]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "reuseID")
        
        cell.textLabel?.text = "Завдання \(indexPath.row + 1)"
        
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if labChoosen == 1 {
            if indexPath.row == 0 {
                guard let lab1taks1VC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: Lab1Task1ViewController.identifier) as? Lab1Task1ViewController else {
                    return
                }
                self.navigationController?.pushViewController(lab1taks1VC, animated: true)
            }
            if indexPath.row == 1 {
                guard let lab1taks2VC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: Lab1Task2ViewController.identifier) as? Lab1Task2ViewController else {
                    return
                }
                self.navigationController?.pushViewController(lab1taks2VC, animated: true)
            }
            if indexPath.row == 2 {
                guard let lab1taks3VC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: Lab1Task3ViewController.identifier) as? Lab1Task3ViewController else {
                    return
                }
                self.navigationController?.pushViewController(lab1taks3VC, animated: true)
            }
        } else if labChoosen == 2 {
            
        } else if labChoosen == 3 {
            
        } else if labChoosen == 4 {
            
        } else if labChoosen == 5 {
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    
}

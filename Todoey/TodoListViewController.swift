//
//  ViewController.swift
//  Todoey
//
//  Created by Shiroshana Tissera on 12/27/18.
//  Copyright © 2018 Shiroshana Tissera. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
  
    let itemArray = ["Find Mike", "Buy Eggos", "Destroy  Demogorgon"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    //MARK - TableView DataSource Methods
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemcell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - Tableview delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let valueOfCell = indexPath.row
//        print (itemArray[valueOfCell])
        
        tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.yellow
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
             tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.white
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.yellow
        }
        
        tableView.deselectRow(at: indexPath, animated: true)

        
        
        
        
    }
 
    
    
    
    

}


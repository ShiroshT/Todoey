//
//  ViewController.swift
//  Todoey
//
//  Created by Shiroshana Tissera on 12/27/18.
//  Copyright © 2018 Shiroshana Tissera. All rights reserved.
//

/* *******************************************************************
// MARK: - define new item array
******************************************************************* */

import UIKit

class TodoListViewController: UITableViewController {
  
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
//    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        
//        let newItem = Item()
        
//        newItem.title = "Fine Mike"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Buy Eggos"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "kill DrogosX"
//        itemArray.append(newItem3)
//
        loadItems()
        
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//             itemArray = items
//        }
    }


    
/* *******************************************************************
       //MARK: - TableView DataSource Methods
******************************************************************* */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemcell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        
//        same as the terniery operator above
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }

/* *******************************************************************
     // MARK: - Tableview delegate Methods
******************************************************************* */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let valueOfCell = indexPath.row
        
//        print (itemArray[valueOfCell])

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
//        tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.yellow
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//             tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.white
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//            tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.yellow
//        }
        
//        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
    }
 
/* *******************************************************************
     //MARK: -  Add new items section
******************************************************************* */


    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks the add item button on UI alert
            
            let newItem = Item()
            
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
//            print("Success!")
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

/* *******************************************************************
     //MARK: -  Model Manupilation Method
****************************************************************** */

    func saveItems() {
        let encorder = PropertyListEncoder()
        do {
            let data = try encorder.encode(itemArray)
            try data.write(to:dataFilePath!)
        } catch {
            print("Error encoding item Array, \(error)")
        }
        //            self.defaults.set(self.itemArray, forKey: "TodoListArray")
        
        self.tableView.reloadData()
    }
    
    func loadItems(){
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                  itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                  print("Error \(error)")
            }
           
        } else {
            
        }
    }
    
    
    
    
    
    
    
    
}


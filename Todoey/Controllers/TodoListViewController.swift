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
//import CoreData
import RealmSwift

class TodoListViewController: UITableViewController {
  
    var todoItems : Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory :Category? {
        didSet {
            loadItems()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print (dataFilePath)
        
//        loadItems()
        
//        tableView.reloadData()
    }


    
/* *******************************************************************
       //MARK: - TableView DataSource Methods
******************************************************************* */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemcell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done == true ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items added"
        }
        
       
        
        
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
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print ("Error created at didSelectRowAt Index \(error)")
            }
        }
        
        
//        let valueOfCell = indexPath.row
        
//        print (itemArray[valueOfCell])

    
//        todoItems[indexPath.row].done = !itemArray[indexPath.row].done /* Add check mark when Clicked*/
//
//        saveItems()
//
//        tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.yellow
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//             tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.white
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//            tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.yellow
//        }
        
        tableView.reloadData()

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
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item() /* this is coming from the Core data*/
                        newItem.title = textField.text!
                        newItem.dateCreated = Date(timeIntervalSinceReferenceDate: -123456789.0)
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error from add Button Pressed /(error)")
                }
            }
            
            self.tableView.reloadData()
            

        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.text = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
//        loadItems()
    }
    

/* *******************************************************************
     //MARK: -  Model Manupilation Method
****************************************************************** */
// Create data -
    func saveItems() {
//        let encorder = PropertyListEncoder()
        
        do {
           try context.save() /* this is coming from the Core data - App delegate end*/
        } catch {
          print("Error Saving Contex \(error)")
        }
      
        
        self.tableView.reloadData()
    }
    
//    Load data - Read data - below -Internal  and external values are set
    
    func loadItems(){
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()

    }



}

/* ---------------------------------------
//MARK: - Search Bar Methods
 --------------------------------------- */
extension TodoListViewController : UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

//            this bit of code - clears the search - explanation in Section 18 -Lectur 244
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }



}

//
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
////        let request: NSFetchRequest<Item> = Item.fetchRequest()
//        print (searchBar.text)
//
//    }
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//        print(searchBar.text!)
//        print("I am here")
//    }
//
//
//}

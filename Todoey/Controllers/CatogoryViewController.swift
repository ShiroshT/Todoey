//
//  CatogoryViewController.swift
//  Todoey
//
//  Created by Shiroshana Tissera on 12/29/18.
//  Copyright © 2018 Shiroshana Tissera. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

class CatogoryViewController: UITableViewController {

    let realm = try! Realm()
    
//    var categoryArrey =  [Category]()
    var categoryArrey: Results<Category>? /* RESULTS is coming from REALEM */

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }

  
    
/* ------------------------------------------------------------------
     //MARK: - TableView DataSource Methods - both of these are oblegatory
-----------------------------------------------------------------*/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArrey?.count ?? 1 /*NIL COALESING OPERATOR*/
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatogoryCell", for: indexPath)

        cell.textLabel?.text = categoryArrey?[indexPath.row].name ??  "No Catergories added yet"

//        cell.textLabel?.text = category.name

        return cell
    }
    

/* ------------------------------------------------------------------
     //MARK: - TableView Delegate Methods
-----------------------------------------------------------------*/
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        self.performSegue(withIdentifier: "gotoTableview", sender: self)

        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArrey?[indexPath.row]
        }
    }

    
    
/* ------------------------------------------------------------------
     //MARK: - Adding Data
-----------------------------------------------------------------*/
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Catogory", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()
            
            newCategory.name = textField.text!
//            self.categoryArrey.append(newCategory)
            self.save(category: newCategory)
        }
        
        /* THere is a problem here*/
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        
        present(alert, animated: true, completion: nil)
//        loadCategory()
        
        
    }

    


    /* *******************************************************************
     //MARK: -  Model Manupilation Method
     ****************************************************************** */
    // Create data -
    func save(category: Category) {
        //        let encorder = PropertyListEncoder()
        do {
            try realm.write {
                realm.add(category)
            } /* this is coming from the Core data - App delegate end*/
        } catch {
            print("Error Saving Contex \(error)")
        }
        
        
        self.tableView.reloadData()
    }
    
    //    Load data - Read data - below -Internal  and external values are set
    
    func loadCategory(){
        
        categoryArrey = realm.objects(Category.self)
        
        
        tableView.reloadData()

    }
    
    
}

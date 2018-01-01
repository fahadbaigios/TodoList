//
//  ViewController.swift
//  Todoey
//
//  Created by Fahad Baig on 27/12/2017.
//  Copyright © 2017 Fahad Inco. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
//    "Find Person", "learn new thing", "complete", "n", "d", "e", "r", "s", "Q", "v", "b", "z", "3", "4", "i"]
//
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Person"
        itemArray.append(newItem)

        let newItem2 = Item()
        newItem2.title = "Person"
        itemArray.append(newItem2)

        let newItem3 = Item()
        newItem3.title = "Demogorgon"
        itemArray.append(newItem3)
        

        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        }
    

  //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell", for: indexPath)
        
        let item = itemArray[indexPath.row]

        cell.textLabel?.text = item.title
        
        //ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Success")

            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)

            self.defaults.set(self.itemArray, forKey: "TodoListArray")

            self.tableView.reloadData()
        }

        alert.addTextField { (alterTextField) in
            alterTextField.placeholder = "Create New Item"
            textField = alterTextField
        }
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }
    
    
}


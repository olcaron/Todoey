//
//  ViewController.swift
//  Todoey
//
//  Created by Olivier Caron on 2019-03-12.
//  Copyright © 2019 Olivier Caron. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(dataFilePath!)
        
        loadItems()
    }// fin de viewDidLoad
    
    //MARK: - Tableview Datasource Methods
    
    //on intialise les cellules et on leur atribut un modele de cellule
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //ternary opperator
        // si la l'accesoire de cell est true on mets le crocher si c'est egale a false on met rien
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }// fin de cellForRowAt
    
    //on declare la quantite de cellules qu'il y aure dans le tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }// fin de numbersOfRowInSection
    
    
    //MARK: - Table view Delegate ( the one that gets fired when any cell is cliqued in the tableview)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // on change la valeur de itemArray.done a l'opposé de la valeur présente p.ex on change true a false
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //on sauvegarde la propriété coché de la cellule dans items.plist
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }// fin de didSelectRow
    
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the add item button on our UIAlert
            // on rajoute l'item a l'array itemArray et on rafraiche le tableView ** on sauvegarde aussi l'array dans les user defaults
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
        }// fin du closure
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }// fin du closure
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    } // fin de add button pressed
    
    //MARK: - Model Manipulation Methods
    // fonction ou l'on sauvegarde les donnés du itemArray dans Items.plist
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array \(error)")
        }// fin du block do catch
        
        // on rafraiche les données du table view
        self.tableView.reloadData()
    }// fin de saveItems
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item Array : \(error)")
            } // fin du do catch
        }// fin du if let
        
    }// fin de loadItems
    
}// fin de TodoListViewController

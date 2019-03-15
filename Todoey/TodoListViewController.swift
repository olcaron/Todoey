//
//  ViewController.swift
//  Todoey
//
//  Created by Olivier Caron on 2019-03-12.
//  Copyright © 2019 Olivier Caron. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArray = ["Find Mike", "Buy eggos", "Destroy demogorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }// fin de viewDidLoad
    
    //MARK - Tableview Datasource Methods
    
    //on intialise les cellules et on leur atribut un modele de cellule
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }// fin de ellForRowAt
    
    //on declare la quantite de cellules qu'il y aure dans le tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }// fin de numbersOfRowInSection
    
    //MARK - Table view Delegate ( the one that gets fired when any cell is cliqued in the tableview)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }//fin du else
        
        tableView.deselectRow(at: indexPath, animated: true)
    }// fin de didSelectRow
    
    
}// fin de TodoListViewController


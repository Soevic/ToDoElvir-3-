//
//  TableViewController.swift
//  ToDoElvir
//
//  Created by Sergey Shatilov on 05.08.2023.
//

import UIKit

class TableViewController: UITableViewController {
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    @IBAction func pushRemoveAction(_ sender: Any) {
     let alertController = UIAlertController(title: "Удалить запись", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "удали запись"
        }
        let alertAction1 = UIAlertAction(title: "Отменить", style: .default) { (alert) in
            
        }
        
        let alertAction2 = UIAlertAction(title: "Удалить", style: .cancel) { (alert) in
            
            var deleteItem = alertController.textFields![0].text // это то что мы вставляем алерт контроллер на удаление, всегда индекс ноль у этого элемента
            
            // Удалить запись вариант 1 - работает, но удаляет только строго по заданному индексу
            
            if ToDoItems[0]["Name"] as? String == deleteItem {
                removeItem(at: 0)
                
                // Удалить запись вариант 2 -  билдится, но в runtime выдает ошибку Index out of range
                
                if !ToDoItems.isEmpty {
                    for index in ToDoItems.indices {
                        if (ToDoItems[index]["Name"] as? String)  == deleteItem  {
                            removeItem(at: index)
                        }
                        
                    }
                }
                
            }
            
            // Удалить запись вариант 3  - билдится, но в runtime выдает ошибку Index out of range
            
            if !ToDoItems.isEmpty {
                for index in ToDoItems.indices {
                    for (_, value) in ToDoItems[index] {
                        if value as? String == deleteItem {
                            
                            removeItem(at: index)
                        }
                        
                    }
                }
            }
            
            
            self.tableView.reloadData()
        }

        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func pushAddAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Новая запись", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "создай новую запись"
        }
        let alertAction1 = UIAlertAction(title: "Отменить", style: .default) { (alert) in
            
        }
        
        let alertAction2 = UIAlertAction(title: "Создать", style: .cancel) { (alert) in
            // Добавить новую запись
            let newItem = alertController.textFields![0].text
            AddItem(nameItem: newItem!)
            self.tableView.reloadData()
        }
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        
        present(alertController, animated: true, completion: nil)
    }
    

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToDoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let currentItem = ToDoItems[indexPath.row]
        cell.textLabel?.text = currentItem["Name"] as? String
        
        if (currentItem["isCompleted"] as? Bool) == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        

        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {

            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

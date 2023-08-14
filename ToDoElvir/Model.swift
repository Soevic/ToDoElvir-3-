//
//  Model.swift
//  ToDoElvir
//
//  Created by Sergey Shatilov on 05.08.2023.
//

import Foundation

var ToDoItems: [[String:Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "ToDoDateKey")
        UserDefaults.standard.synchronize()
    }
    
    get {
        if let array = UserDefaults.standard.array(forKey: "ToDoDateKey") as? [[String: Any]]{
            return array
        } else {
            return []
        }
    }
}

    


func AddItem(nameItem: String, isCompleted: Bool = false) {
    ToDoItems.append(["Name": nameItem,"isCompleted": false])
    }

func removeItem(at index: Int) {
    ToDoItems.remove(at: index )
    }
    


func changeState(at item: Int) -> Bool {
    ToDoItems[item]["isCompleted"] = !(ToDoItems[item]["isCompleted"] as! Bool)
    
    return ToDoItems[item]["isCompleted"] as! Bool
}








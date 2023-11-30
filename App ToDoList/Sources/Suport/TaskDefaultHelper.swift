//
//  TaskDefaultHelper.swift
//  App ToDoList
//
//  Created by Felipe Santos on 28/11/23.
//

import Foundation

class TaskDefaultHelper {
    
    let keyTask: String = "kAcessTask"
    
    public func saveListTask(_ listTask: [Task]) {
        do {
            let list = try JSONEncoder().encode(listTask)
            UserDefaults.standard.set(list, forKey: keyTask)
        }
        catch {
            print(error)
        }
    }
    
    public func getListTask() -> [Task] {
        var taskList: [Task] = []
        do {
            guard let list = UserDefaults.standard.object(forKey: self.keyTask) else { return taskList }
            taskList = try JSONDecoder().decode([Task].self, from: list as! Data)
        }
        catch {
            print(error)
        }
        
        return taskList
    }
    
    public func updateTask(_ task: Task) {
        var list: [Task] = getListTask()
        list.removeAll { currentTask in
            return currentTask.id == task.id
        }
        list.append(task)
        saveListTask(list)
    }
    
    public func deletaeTask(_ task: Task) {
        var list: [Task] = getListTask()
        guard let deleteTaskIndex = list.firstIndex(where: { $0.id == task.id }) else { return }
        list.remove(at: deleteTaskIndex)
        saveListTask(list)
    }
}

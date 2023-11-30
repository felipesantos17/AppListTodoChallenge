//
//  Task.swift
//  App ToDoList
//
//  Created by Felipe Santos on 28/11/23.
//

import Foundation

class Task: Codable {
    var id: UUID
    var title: String
    var time: String
    var date: String
    
    init(id: UUID, title: String, time: String, date: String) {
        self.id = id
        self.title = title
        self.time = time
        self.date = date
    }
}

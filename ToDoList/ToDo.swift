//
//  ToDo.swift
//  ToDoList
//
//  Created by Lucy Xu on 8/24/20.
//  Copyright © 2020 flick. All rights reserved.
//

import Foundation

class ToDo {
    var description: String
    var completed: Bool
    var starred: Bool
    var subTodos: [ToDo]

    init(description: String, completed: Bool, starred: Bool) {
        self.description = description
        self.completed = completed
        self.starred = starred
        self.subTodos = []
    }
}

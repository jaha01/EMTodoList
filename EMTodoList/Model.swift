//
//  Model.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 10.04.2025.
//

import Foundation

struct TodoResponse: Codable {
    let todos: [TodoItem]
    let total: Int
    let skip: Int
    let limit: Int
}

struct TodoItem: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}

class CustomError: Error {
    var message: String
    init(message: String) {
        self.message = message
    }
}

//
//  TodoItem.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 16.04.2025.
//

import Foundation

struct TodoItem: Codable {
    let id: Int
    let todo: String
    var completed: Bool
    let userId: Int
}

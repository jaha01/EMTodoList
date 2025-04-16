//
//  DBModel.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 16.04.2025.
//

import Foundation

struct Task: Codable { 
    var id: Int16
    var title: String?
    var taskDescription: String?
    var isCompleted: Bool
    var date: Date?
}

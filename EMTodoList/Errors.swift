//
//  Errors.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 16.04.2025.
//

import Foundation

class CustomError: Error { // +
    var message: String
    init(message: String) {
        self.message = message
    }
}

//
//  NetworkManager.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 10.04.2025.
//

import Foundation

final class DI {
    
    static let shared = DI()

    lazy var networkClient: NetworkManager = {
        return NetworkManager()
    }()
    
}

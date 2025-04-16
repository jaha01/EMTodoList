//
//  NetworkManager.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 10.04.2025.
//

import Foundation

final class DI {
    
    static let shared = DI()

    lazy var networkClient: NetworkService = {
        return NetworkService()
    }()
    
    lazy var dBClient: DBService = {
        return DBService()
    }()
    
}

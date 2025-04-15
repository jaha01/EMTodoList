//
//  Interactor.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 10.04.2025.
//

import UIKit

protocol InteractorProtocol {
    func load()
    func goToTaskInfo(task: TodoItem)
}

final class Interactor: InteractorProtocol {
    
    // MARK: - Public properties
    
    var presenter: PresenterProtocol!
    var router: Router!
    var networkService: NetworkManagerProtocol!
    
    init(networkService: NetworkManagerProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Public methods
    
    func load() {
        networkService.request { [weak self] result in
            switch result {
            case .success(let session):
                self?.presenter.prepareTasks(tasks: session.todos, tasksCount: session.todos.count)
            case .failure(_):
                print("ERROR")
            }
        }
    }
    
    func goToTaskInfo(task: TodoItem) {
        router.goToTaskInfo(task: task)
    }
    
    
}

//
//  TaskInfoInteractor.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 11.04.2025.
//

import Foundation

protocol TaskInfoInteractorProtocol {
    func onLoad()
}

final class TaskInfoInteractor: TaskInfoInteractorProtocol {
    
    // MARK: - Public properties
    
    var presenter: TaskInfoPresenterProtocol!
    
    // MARK: - Private properties
    
    var task: Task!
    
    func onLoad() {
        presenter.prepareTask(task: task)
    }
    
}

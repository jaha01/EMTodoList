//
//  TaskInfoInteractor.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 11.04.2025.
//

import Foundation

protocol TaskInfoInteractorProtocol {
    func onLoad()
    func onClose(title: String, description: String)
}

final class TaskInfoInteractor: TaskInfoInteractorProtocol {
    
    // MARK: - Public properties
    
    var presenter: TaskInfoPresenterProtocol!
    
    // MARK: - Private properties
    
    private var task: Task
    private let onCloseCompletion: (Task) -> Void
    
    init(task: Task, onClose: @escaping ((Task) -> Void)) {
        self.task = task
        self.onCloseCompletion = onClose
    }

    // MARK: - Public methods
    
    func onLoad() {
        presenter.prepareTask(task: task)
    }
    
    func onClose(title: String, description: String) {
        if task.title != title || task.taskDescription != description {
            onCloseCompletion(Task(id: task.id,
                                   title: title,
                                   taskDescription: description,
                                   isCompleted: task.isCompleted,
                                   date: Date())) 
        }
    }
}

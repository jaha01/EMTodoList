//
//  TaskInfoPresenter.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 11.04.2025.
//

import Foundation

protocol TaskInfoPresenterProtocol {
    func prepareTask(task: Task)
}

final class TaskInfoPresenter: TaskInfoPresenterProtocol {
    
    // MARK: - Public properties
   
    var viewController: TaskInfoViewControllerProtocol!
    
    // MARK: - Public methods
    
    func prepareTask(task: Task) {
        viewController.showTask(task: task)
    }
}

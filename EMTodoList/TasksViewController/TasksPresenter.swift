//
//  Presenter.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 10.04.2025.
//

import UIKit

protocol TasksPresenterProtocol {
    func prepareTasks(tasks: [Task])
}

final class TasksPresenter: TasksPresenterProtocol {
 
    // MARK: - Public properties
   
    var viewController: TasksViewControllerProtocol!
 
    // MARK: - Public properties
    
    func prepareTasks(tasks: [Task]) {
        viewController.showTasks(tasks: tasks)
    }
}

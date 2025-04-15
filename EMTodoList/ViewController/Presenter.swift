//
//  Presenter.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 10.04.2025.
//

import UIKit

protocol PresenterProtocol {
    func prepareTasks(tasks: [Task], tasksCount: Int)
}

final class Presenter: PresenterProtocol {
 
    // MARK: - Public properties
   
    var viewController: ViewControllerProtocol!
 
    // MARK: - Public properties
    
    func prepareTasks(tasks: [Task], tasksCount: Int) {
        viewController.showTasks(tasks: tasks, tasksCount: tasksCount)
    }
}

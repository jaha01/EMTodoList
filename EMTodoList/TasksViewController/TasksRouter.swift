//
//  Router.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 10.04.2025.
//

import UIKit

protocol TasksRouterProtocol {
    func goToTaskInfo(task: Task, onClose: @escaping ((Task) -> Void) )
}

final class TasksRouter: TasksRouterProtocol {
    
    // MARK: - Public properties
    
    var viewController: UIViewController!
    
    // MARK: - Public properties
    
    func goToTaskInfo(task: Task, onClose: @escaping ((Task) -> Void)) {
        guard let controller = viewController else { return }
        let taskVC = TaskInfoBuilder().build(task: task, onClose: onClose)
        controller.navigationController?.pushViewController(taskVC, animated: true)
    }
}

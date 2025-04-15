//
//  Router.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 10.04.2025.
//

import UIKit

protocol RouterProtocol {
    func goToTaskInfo(task: TodoItem)
}

final class Router: RouterProtocol {
    
    // MARK: - Public properties
    
    var viewController: UIViewController!
    
    // MARK: - Public properties
    
    func goToTaskInfo(task: TodoItem) {
        guard let controller = viewController else { return }
        let taskVC = TaskInfoBuilder().build(task: task)
        controller.navigationController?.pushViewController(taskVC, animated: true)
    }
}

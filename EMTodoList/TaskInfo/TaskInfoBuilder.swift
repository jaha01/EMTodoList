//
//  TaskInfoBuilder.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 11.04.2025.
//

import UIKit

final class TaskInfoBuilder {
    
    func build(task: Task, onClose: @escaping ((Task) -> Void)) -> UIViewController {
        let controller = TaskInfoViewController()
        let interactor = TaskInfoInteractor(task: task, onClose: onClose)
        let presenter = TaskInfoPresenter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        
        return controller
    }
}

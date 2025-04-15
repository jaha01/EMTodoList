//
//  TaskInfoBuilder.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 11.04.2025.
//

import UIKit

final class TaskInfoBuilder {
    
    func build(task: Task) -> UIViewController {
        let controller = TaskInfoViewController()
        let interactor = TaskInfoInteractor()
        let presenter = TaskInfoPresenter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        interactor.task = task
        presenter.viewController = controller
        
        return controller
    }
}

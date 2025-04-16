//
//  Builder.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 10.04.2025.
//

import UIKit

final class TasksBuilder {
    
    func build() -> UIViewController {
        let controller = TasksViewController()
        let interactor = TasksInteractor(networkService: DI.shared.networkClient, dBService: DI.shared.dBClient)
        let presenter = TasksPresenter()
        let router = TasksRouter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        router.viewController = controller
        interactor.router = router
        
        return controller
    }
}

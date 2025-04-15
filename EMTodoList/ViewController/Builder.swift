//
//  Builder.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 10.04.2025.
//

import UIKit

final class Builder {
    
    func build() -> UIViewController {
        let controller = ViewController()
        let interactor = Interactor(networkService: DI.shared.networkClient, coreData: DI.shared.coreData)
        let presenter = Presenter()
        let router = Router()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        router.viewController = controller
        interactor.router = router
        
        return controller
    }
}

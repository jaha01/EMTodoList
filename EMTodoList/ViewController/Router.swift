//
//  Router.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 10.04.2025.
//

import UIKit

protocol RouterProtocol {
    func goToTaskInfo()
}

final class Router: RouterProtocol {
    
    // MARK: - Public properties
    
    var viewController: UIViewController!
    
    func goToTaskInfo() {
//        guard let controller = viewController else { return }
//        let paymentVC = PaymentBuilder().build(selectedSeats: selectedSeats)
//        let nav = UINavigationController(rootViewController: paymentVC)
//        nav.navigationBar.backgroundColor = .white
//        controller.present(nav, animated: true, completion: nil)
    }
}

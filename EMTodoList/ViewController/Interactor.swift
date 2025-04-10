//
//  Interactor.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 10.04.2025.
//

import UIKit

protocol InteractorProtocol {

}

final class Interactor: InteractorProtocol {
    
    // MARK: - Public properties
    
    var presenter: PresenterProtocol!
    var router: Router!
    
}

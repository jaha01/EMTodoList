//
//  TaskInfoPresenter.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 11.04.2025.
//

import Foundation

protocol TaskInfoPresenterProtocol {
    func prepareTask(task: Task)
}

final class TaskInfoPresenter: TaskInfoPresenterProtocol {
    
    // MARK: - Public properties
   
    var viewController: TaskInfoViewControllerProtocol!
    
    // MARK: - Private properties
    
    private let formatter: DateFormatter  = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        formatter.locale = .current
        formatter.timeZone = .current
        return formatter
    }()
    
    // MARK: - Public methods
    
    func prepareTask(task: Task) {
        viewController.showTask(task: task, formatedDate: formatDateToString(task.date))
    }
    
    // MARK: - Private properties
    
    private func formatDateToString(_ date: Date?) -> String {
        if let safeDate = date {
            return formatter.string(from: safeDate)
        } else {
            return ""
        }
    }
}

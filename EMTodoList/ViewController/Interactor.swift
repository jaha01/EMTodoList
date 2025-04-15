//
//  Interactor.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 10.04.2025.
//

import UIKit
import CoreData

protocol InteractorProtocol {
    func load()
    func goToTaskInfo(task: TodoItem)
    func loadCoreData()
    func saveTask(task: Task)
}

final class Interactor: InteractorProtocol {
    
    // MARK: - Public properties
    
    var presenter: PresenterProtocol!
    var router: Router!
    var networkService: NetworkManagerProtocol!
    var coreData: CoreDataProtocol!
    
    var tasks = [Task]()
    
    init(networkService: NetworkManagerProtocol,
         coreData: CoreDataProtocol
    ) {
        self.networkService = networkService
        self.coreData = coreData
    }
    
    // MARK: - Public methods
    
    func load() {
        networkService.request { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let session):
                session.todos.forEach { task in
                    self.coreData.saveTodo(item: Task(id: Int16(task.id),
                                                      title: "",
                                                      taskDescription: task.todo,
                                                      isCompleted: task.completed,
                                                      date: nil))
                }
                self.loadCoreData()
            case .failure(_):
                print("ERROR")
            }
        }
    }
    

    func goToTaskInfo(task: TodoItem) {
        router.goToTaskInfo(task: task)
    }
  
    func loadCoreData() {
        coreData.fetchTodos { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                self.tasks = data.map { entity in
                    Task(id: entity.id,
                         title: entity.title,
                         taskDescription: entity.taskDescription,
                         isCompleted: entity.isCompleted,
                         date: entity.date)
                }
                self.presenter.prepareTasks(tasks: self.tasks, tasksCount: self.tasks.count)
            case .failure(_):
                print("Error")
            }
        }
        print("tasks = \(tasks)")
    }
    
    func saveTask(task: Task) {
        
        coreData.saveTodo(item: task)
        loadCoreData()

    }   
}

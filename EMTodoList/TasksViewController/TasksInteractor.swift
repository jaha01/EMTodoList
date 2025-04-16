//
//  Interactor.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 10.04.2025.
//

import UIKit
import CoreData

protocol TasksInteractorProtocol {
    func load()
    func goToTaskInfo(task: Task)
    func loadDB()
    func saveTask(task: Task)
    func editTask(task: Task)
    func deleteTask(id: Int16)
    func changeTaskStatus(_ id: Int16)
}

final class TasksInteractor: TasksInteractorProtocol {
    
    // MARK: - Public properties
    
    var presenter: TasksPresenterProtocol!
    var router: TasksRouter!
    
    // MARK: - Private properties
    
    private let networkService: NetworkServiceProtocol 
    private let dBService: DBProtocol 
    private var tasks = [Task]()
    
    init(networkService: NetworkServiceProtocol,
         dBService: DBProtocol
    ) {
        self.networkService = networkService
        self.dBService = dBService
    }
    
    // MARK: - Public methods
    
    func load() {
        networkService.request { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let session):
                session.todos.forEach { task in
                    self.dBService.saveTodo(item: Task(id: Int16(task.id),
                                                      title: "",
                                                      taskDescription: task.todo,
                                                      isCompleted: task.completed,
                                                      date: nil))
                }
                self.loadDB()
            case .failure(_):
                print("ERROR")
            }
        }
    }
    

    func goToTaskInfo(task: Task) {
        router.goToTaskInfo(task: task, onClose: updateTask)
    }
  
    func loadDB() {
        dBService.fetchTodos { [weak self] result in
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
                self.presenter.prepareTasks(tasks: self.tasks)
            case .failure(_):
                print("Error")
            }
        }
    }
    
    func saveTask(task: Task) {
        dBService.saveTodo(item: task)
        tasks.append(task)
        self.presenter.prepareTasks(tasks: self.tasks)
    }
    
    func editTask(task: Task) {
        dBService.updateTodo(item: task)
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].title = task.title
            tasks[index].isCompleted = task.isCompleted
            tasks[index].taskDescription = task.taskDescription
            tasks[index].date = task.date
        }
        presenter.prepareTasks(tasks: self.tasks)
    }
    
    func deleteTask(id: Int16) {
        dBService.deleteTodo(id)
        tasks.removeAll { $0.id == id }
        presenter.prepareTasks(tasks: self.tasks)
    }
    
    func changeTaskStatus(_ id: Int16) {
        dBService.changeTaskStatus(id)
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks[index].isCompleted.toggle()
        }
        presenter.prepareTasks(tasks: self.tasks)
    }
    
    // MARK: - Private methods
    
    private func updateTask(task: Task) {
        print("110")
        editTask(task: task)
    }
}

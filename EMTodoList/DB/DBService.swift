//
//  CoreData.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 14.04.2025.
//

import Foundation
import CoreData

protocol DBProtocol {
    func fetchTodos(completion: @escaping(Result<[ToDoEntity],Error>)->Void)
    func saveTodo(item: Task)
    func getNextAvailableID() -> Int16
//    func deleteAllTodos()
    func updateTodo(item: Task)
    func deleteTodo(_ id: Int16)
    func changeTaskStatus(_ id: Int16)
}

final class DBService: DBProtocol {

    let persistentContainer: NSPersistentContainer

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    init() {
        persistentContainer = NSPersistentContainer(name: "ToDoModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data: \(error)")
            }
        }
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving Core Data context: \(error)")
            }
        }
    }
    
    
    func fetchTodos(completion: @escaping(Result<[ToDoEntity],Error>)->Void) {
        let context = context
        let request: NSFetchRequest<ToDoEntity> = ToDoEntity.fetchRequest()

        do {
            let result = try context.fetch(request)
            completion(.success(result))
        } catch {
            print("Failed to fetch: \(error)")
            completion(.failure(error))
        }
    }
 
    func updateTodo(item: Task) {
        let context = context

        let fetchRequest: NSFetchRequest<ToDoEntity> = ToDoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", item.id)

        do {
            let existing = try context.fetch(fetchRequest)
            if let entity = existing.first {
                entity.title = item.title
                entity.taskDescription = item.taskDescription
                entity.isCompleted = item.isCompleted
                entity.date = item.date
                saveContext()
            } else {
                print("Задача с id \(item.id) не найдена для обновления")
            }
        } catch {
            print("Ошибка при обновлении задачи: \(error.localizedDescription)")
        }
    }

    func getNextAvailableID() -> Int16 {
        let fetchRequest: NSFetchRequest<ToDoEntity> = ToDoEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]

        do {
            let result = try context.fetch(fetchRequest)
            if let maxEntity = result.first {
                return maxEntity.id + 1
            } else {
                return 1
            }
        } catch {
            print("Failed to fetch max id: \(error)")
            return 1
        }
    }
    
    func deleteAllTodos() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ToDoEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Ошибка при удалении всех записей: \(error)")
        }
    }

    func saveTodo(item: Task) {
        let context = context
        var newTask =  item
        
        if newTask.id == 0 {
            newTask.id = getNextAvailableID()
        }
        
        let fetchRequest: NSFetchRequest<ToDoEntity> = ToDoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", item.id)

        do {
            let existing = try context.fetch(fetchRequest)
            if existing.isEmpty {
                let entity = ToDoEntity(context: context)
                entity.id = newTask.id // Уже пришёл из сети
                entity.title = newTask.title
                entity.taskDescription = newTask.taskDescription
                entity.isCompleted = newTask.isCompleted
                entity.date = newTask.date

                saveContext()
            }
        } catch {
            print("Ошибка при проверке существующей задачи: \(error.localizedDescription)")
        }
    }

    func deleteTodo(_ id: Int16) {
        let context = context
        let request: NSFetchRequest<ToDoEntity> = ToDoEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)

        if let result = try? context.fetch(request).first {
            context.delete(result)
            saveContext()
        }
    }
    
    func changeTaskStatus(_ id: Int16) {
        let context = context
        let fetchRequest: NSFetchRequest<ToDoEntity> = ToDoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)

        do {
            let existing = try context.fetch(fetchRequest)
            if let entity = existing.first {
                entity.isCompleted.toggle()
                saveContext()
            }
        } catch {
            print("Ошибка при обновлении задачи: \(error.localizedDescription)")
        }
    }
    
}

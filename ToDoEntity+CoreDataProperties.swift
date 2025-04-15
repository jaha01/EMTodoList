//
//  ToDoEntity+CoreDataProperties.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 15.04.2025.
//
//

import Foundation
import CoreData


extension ToDoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoEntity> {
        return NSFetchRequest<ToDoEntity>(entityName: "ToDoEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var taskDescription: String?
    @NSManaged public var title: String?
    @NSManaged public var id: Int16

}

extension ToDoEntity : Identifiable {

}

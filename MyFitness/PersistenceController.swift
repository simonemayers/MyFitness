//
//  PersistenceController.swift
//  MyFitness
//
//  Created by Owner on 10/5/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FitnessApp")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

// MARK: - Core Data Managed Object Subclasses

extension User {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
//
//    @NSManaged public var id: UUID
//    @NSManaged public var name: String
//    @NSManaged public var age: Int16
//    @NSManaged public var height: Double
//    @NSManaged public var weight: Double
//    @NSManaged public var dailyCalorieGoal: Int32
//    @NSManaged public var foodLogs: NSSet?
//    @NSManaged public var exerciseLogs: NSSet?
}

extension FoodItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodItem> {
        return NSFetchRequest<FoodItem>(entityName: "FoodItem")
    }
//
//    @NSManaged public var id: UUID
//    @NSManaged public var name: String
//    @NSManaged public var calories: Int32
//    @NSManaged public var protein: Double
//    @NSManaged public var carbs: Double
//    @NSManaged public var fat: Double
//    @NSManaged public var foodLogs: NSSet?
}

extension FoodLog {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodLog> {
        return NSFetchRequest<FoodLog>(entityName: "FoodLog")
    }
//
//    @NSManaged public var id: UUID
//    @NSManaged public var date: Date
//    @NSManaged public var quantity: Double
//    @NSManaged public var user: User?
//    @NSManaged public var foodItem: FoodItem?
}

extension ExerciseLog {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseLog> {
        return NSFetchRequest<ExerciseLog>(entityName: "ExerciseLog")
    }
//
//    @NSManaged public var id: UUID
//    @NSManaged public var date: Date
//    @NSManaged public var duration: Double
//    @NSManaged public var caloriesBurned: Int32
//    @NSManaged public var exerciseType: String
//    @NSManaged public var user: User?
}

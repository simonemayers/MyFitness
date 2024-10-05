//
//  fitness-app-user-data.swift
//  MyFitness
//
//  Created by Owner on 10/5/24.
//

import SwiftUI
import CoreData

class UserData: ObservableObject {
    let container: NSPersistentContainer
    @Published var foodLogs: [FoodLog] = []
    @Published var currentUser: User? = nil
    @Published var foodItems: [FoodItem] = []

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FitnessApp")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            else{
                self.initializeData()

            }
        }
//        fetchCurrentUser()
//        fetchFoodItems()
    }
    
    // Initialize data after the persistent container is ready
    private func initializeData() {
        fetchCurrentUser()
        fetchFoodItems()
    }

    func fetchCurrentUser() {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.fetchLimit = 1
        
        do {
            let results = try container.viewContext.fetch(request)
            if let user = results.first {
                currentUser = user
            } else {
                createDefaultUser()
            }
        } catch {
            print("Error fetching user: \(error)")
        }
    }

    func createDefaultUser() {
        let newUser = User(context: container.viewContext)
        newUser.id = UUID()
        newUser.name = "New User"
        newUser.age = 30
        newUser.height = 170
        newUser.weight = 70
        newUser.dailyCalorieGoal = 2000
        
        do {
            try container.viewContext.save()
            currentUser = newUser
        } catch {
            print("Error creating default user: \(error)")
        }
    }

    func fetchFoodItems() {
        let request: NSFetchRequest<FoodItem> = FoodItem.fetchRequest()
        
        do {
            foodItems = try container.viewContext.fetch(request)
            if foodItems.isEmpty {
                createDefaultFoodItems()
            }
        } catch {
            print("Error fetching food items: \(error)")
        }
    }

    func createDefaultFoodItems() {
        let defaultFoods = [
            ("Apple", 95, 0.5, 25.0, 0.3),
            ("Banana", 105, 1.3, 27.0, 0.4),
            ("Chicken Breast", 165, 31.0, 0.0, 3.6),
            ("Salmon", 206, 22.0, 0.0, 13.0),
            ("Brown Rice", 216, 5.0, 45.0, 1.6)
        ]

        for food in defaultFoods {
            let newFood = FoodItem(context: container.viewContext)
            newFood.id = UUID()
            newFood.name = food.0
            newFood.calories = Int32(food.1)
            newFood.protein = food.2
            newFood.carbs = food.3
            newFood.fat = food.4
        }

        do {
            try container.viewContext.save()
            fetchFoodItems()
        } catch {
            print("Error creating default food items: \(error)")
        }
    }

    func addFoodLog(foodItem: FoodItem, quantity: Double) {
        guard let user = currentUser else { return }
        
        let newLog = FoodLog(context: container.viewContext)
        newLog.id = UUID()
        newLog.date = Date()
        newLog.quantity = quantity
        newLog.user = user
        newLog.foodItem = foodItem

        do {
            try container.viewContext.save()
        } catch {
            print("Error saving food log: \(error)")
        }
    }

    func addExerciseLog(exerciseType: String, duration: Double, caloriesBurned: Int) {
        guard let user = currentUser else { return }
        
        let newLog = ExerciseLog(context: container.viewContext)
        newLog.id = UUID()
        newLog.date = Date()
        newLog.duration = duration
        newLog.caloriesBurned = Int32(caloriesBurned)
        newLog.exerciseType = exerciseType
        newLog.user = user

        do {
            try container.viewContext.save()
        } catch {
            print("Error saving exercise log: \(error)")
        }
    }

    func totalCaloriesForToday() -> Int {
        guard let user = currentUser else { return 0 }
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        let request: NSFetchRequest<FoodLog> = FoodLog.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@ AND date >= %@ AND date < %@", user, today as NSDate, tomorrow as NSDate)
        
        do {
            let logs = try container.viewContext.fetch(request)
            return logs.reduce(0) { $0 + Int($1.quantity * Double($1.foodItem?.calories ?? 0)) }
        } catch {
            print("Error fetching food logs: \(error)")
            return 0
        }
    }

    func totalCaloriesBurnedForToday() -> Int {
        guard let user = currentUser else { return 0 }
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        let request: NSFetchRequest<ExerciseLog> = ExerciseLog.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@ AND date >= %@ AND date < %@", user, today as NSDate, tomorrow as NSDate)
        
        do {
            let logs = try container.viewContext.fetch(request)
            return logs.reduce(0) { $0 + Int($1.caloriesBurned) }
        } catch {
            print("Error fetching exercise logs: \(error)")
            return 0
        }
    }

    func updateUser(name: String, age: Int, height: Double, weight: Double, dailyCalorieGoal: Int) {
        guard let user = currentUser else { return }
        
        user.name = name
        user.age = Int16(age)
        user.height = height
        user.weight = weight
        user.dailyCalorieGoal = Int32(dailyCalorieGoal)

        do {
            try container.viewContext.save()
            objectWillChange.send()
        } catch {
            print("Error updating user: \(error)")
        }
    }
}

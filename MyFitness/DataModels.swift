import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Identifiable, Codable {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var age: Int16
    @NSManaged public var height: Double
    @NSManaged public var weight: Double
    @NSManaged public var dailyCalorieGoal: Int32
    @NSManaged public var foodLogs: NSSet?
    @NSManaged public var exerciseLogs: NSSet?

    enum CodingKeys: String, CodingKey {
        case id, name, age, height, weight, dailyCalorieGoal
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(height, forKey: .height)
        try container.encode(weight, forKey: .weight)
        try container.encode(dailyCalorieGoal, forKey: .dailyCalorieGoal)
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(context: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int16.self, forKey: .age)
        height = try container.decode(Double.self, forKey: .height)
        weight = try container.decode(Double.self, forKey: .weight)
        dailyCalorieGoal = try container.decode(Int32.self, forKey: .dailyCalorieGoal)
    }
}



@objc(FoodItem)
public class FoodItem: NSManagedObject, Identifiable, Codable {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var calories: Int32
    @NSManaged public var protein: Double
    @NSManaged public var carbs: Double
    @NSManaged public var fat: Double
    @NSManaged public var foodLogs: NSSet?

    enum CodingKeys: String, CodingKey {
        case id, name, calories, protein, carbs, fat
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(calories, forKey: .calories)
        try container.encode(protein, forKey: .protein)
        try container.encode(carbs, forKey: .carbs)
        try container.encode(fat, forKey: .fat)
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(context: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        calories = try container.decode(Int32.self, forKey: .calories)
        protein = try container.decode(Double.self, forKey: .protein)
        carbs = try container.decode(Double.self, forKey: .carbs)
        fat = try container.decode(Double.self, forKey: .fat)
    }
}


@objc(FoodLog)
public class FoodLog: NSManagedObject, Identifiable, Codable {
    @NSManaged public var id: UUID
    @NSManaged public var date: Date
    @NSManaged public var quantity: Double
    @NSManaged public var user: User?
    @NSManaged public var foodItem: FoodItem?

    enum CodingKeys: String, CodingKey {
        case id, date, quantity, userId, foodItemId
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(user?.id, forKey: .userId)
        try container.encode(foodItem?.id, forKey: .foodItemId)
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(context: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        date = try container.decode(Date.self, forKey: .date)
        quantity = try container.decode(Double.self, forKey: .quantity)
        // User and FoodItem relationships need to be set separately
    }
}

@objc(ExerciseLog)
public class ExerciseLog: NSManagedObject, Identifiable, Codable {
    @NSManaged public var id: UUID
    @NSManaged public var date: Date
    @NSManaged public var duration: Double
    @NSManaged public var caloriesBurned: Int32
    @NSManaged public var exerciseType: String
    @NSManaged public var user: User?

    enum CodingKeys: String, CodingKey {
        case id, date, duration, caloriesBurned, exerciseType, userId
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(duration, forKey: .duration)
        try container.encode(caloriesBurned, forKey: .caloriesBurned)
        try container.encode(exerciseType, forKey: .exerciseType)
        try container.encode(user?.id, forKey: .userId)
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(context: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        date = try container.decode(Date.self, forKey: .date)
        duration = try container.decode(Double.self, forKey: .duration)
        caloriesBurned = try container.decode(Int32.self, forKey: .caloriesBurned)
        exerciseType = try container.decode(String.self, forKey: .exerciseType)
        // User relationship needs to be set separately
    }
}

enum DecoderConfigurationError: Error {
    case missingManagedObjectContext
}

extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

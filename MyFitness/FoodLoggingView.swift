import SwiftUI

struct FoodLoggingView: View {
    @EnvironmentObject var userData: UserData
    @State private var selectedFood: FoodItem?
    @State private var quantity: Double = 1.0
    @State private var showingFoodPicker = false
    
    var body: some View {
        NavigationView {
            SwiftUI.Form {
                LogFoodSection(selectedFood: $selectedFood, quantity: $quantity, showingFoodPicker: $showingFoodPicker)
                
                TodaysLogSection()
                
                SummarySection()
            }
            .navigationTitle("Food Log")
            .sheet(isPresented: $showingFoodPicker) {
                FoodPickerView(selectedFood: $selectedFood)
            }
        }
    }
}



struct LogFoodSection: View {
    @Binding var selectedFood: FoodItem?
    @Binding var quantity: Double
    @Binding var showingFoodPicker: Bool
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        Section(header: Text("Log Food")) {
            Button("Select Food") {
                showingFoodPicker = true
            }
            if let food = selectedFood {
                Text(food.name)
                Stepper(value: $quantity, in: 0.5...10, step: 0.5) {
                    Text("Quantity: \(quantity, specifier: "%.1f")")
                }
                Button("Add to Log") {
                    userData.addFoodLog(foodItem: food, quantity: quantity)
                    selectedFood = nil
                    quantity = 1.0
                }
            }
        }
    }

}
    
    
struct TodaysLogSection: View {
    @EnvironmentObject var userData: UserData
    
    // Helper function to get today's food logs
    func todaysFoodLogs() -> [FoodLog] {
        return userData.foodLogs.filter { Calendar.current.isDateInToday($0.date) }
    }
    
    var body: some View {
        Section(header: Text("Today's Log")) {
            ForEach(todaysFoodLogs()) { log in
                if let food = log.foodItem {
                    HStack {
                        Text(food.name)
                        Spacer()
                        Text("\(Int(Double(food.calories) * log.quantity)) cal")
                    }
                } else {
                    Text("Food item missing")
                }
            }
        }
    }

}
    
struct SummarySection: View {
    @EnvironmentObject var userData: UserData
    var body: some View {
        Section(header: Text("Summary")) {
            HStack {
                Text("Total Calories")
                Spacer()
                Text("\(userData.totalCaloriesForToday())")
            }
            HStack {
                Text("Calorie Goal")
                Spacer()
                if let user = userData.currentUser {
                    Text("\(user.dailyCalorieGoal)")
                } else {
                    Text("Not set") // Fallback message if `currentUser` is nil
                }
            }
        }
    }

}
    


struct FoodLoggingView_Previews: PreviewProvider {
    static var previews: some View {
        FoodLoggingView().environmentObject(UserData())
    }
}

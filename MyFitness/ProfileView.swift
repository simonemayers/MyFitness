//
//  ProfileView.swift
//  MyFitness
//
//  Created by Owner on 10/5/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userData: UserData
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var dailyCalorieGoal: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $name)
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                    TextField("Height (cm)", text: $height)
                        .keyboardType(.decimalPad)
                    TextField("Weight (kg)", text: $weight)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Goals")) {
                    TextField("Daily Calorie Goal", text: $dailyCalorieGoal)
                        .keyboardType(.numberPad)
                }
                
                Button("Save Changes") {
                    saveProfile()
                }
            }
            .navigationTitle("Profile")
            .onAppear(perform: loadProfile)
        }
    }
    
    private func loadProfile() {
        guard let user = userData.currentUser else { return }
        name = user.name
        age = String(user.age)
        height = String(user.height)
        weight = String(user.weight)
        dailyCalorieGoal = String(user.dailyCalorieGoal)
    }
    
    private func saveProfile() {
        guard let ageInt = Int(age),
              let heightDouble = Double(height),
              let weightDouble = Double(weight),
              let calorieGoalInt = Int(dailyCalorieGoal) else {
            // Handle invalid input
            return
        }
        
        userData.updateUser(name: name, age: ageInt, height: heightDouble, weight: weightDouble, dailyCalorieGoal: calorieGoalInt)
    }
}

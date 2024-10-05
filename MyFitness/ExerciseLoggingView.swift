//
//  ExerciseLoggingView.swift
//  MyFitness
//
//  Created by Owner on 10/5/24.
//

import SwiftUI

struct ExerciseLoggingView: View {
    @EnvironmentObject var userData: UserData
    @State private var exerciseType = ""
    @State private var duration = 30.0
    @State private var caloriesBurned = 100

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Log Exercise")) {
                    TextField("Exercise Type", text: $exerciseType)
                    
                    Stepper(value: $duration, in: 5...240, step: 5) {
                        Text("Duration: \(Int(duration)) minutes")
                    }
                    
                    Stepper(value: $caloriesBurned, in: 10...2000, step: 10) {
                        Text("Calories Burned: \(caloriesBurned)")
                    }
                    
                    Button("Add Exercise") {
                        userData.addExerciseLog(exerciseType: exerciseType, duration: duration, caloriesBurned: caloriesBurned)
                        exerciseType = ""
                        duration = 30.0
                        caloriesBurned = 100
                    }
                }
                
                Section(header: Text("Today's Exercises")) {
                    // Implement a list of today's logged exercises here
                    Text("List of today's exercises")
                }
            }
            .navigationTitle("Exercise Log")
        }
    }
}


//
//  fitness-app-main-views.swift
//  MyFitness
//
//  Created by Owner on 10/5/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Dashboard")
                }
                .tag(0)
            
            FoodLoggingView()
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("Food")
                }
                .tag(1)
            
            ExerciseLoggingView()
                .tabItem {
                    Image(systemName: "figure.walk")
                    Text("Exercise")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(3)
        }
    }
}

struct DashboardView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    TodaySummaryView()
                    WeeklyProgressView()
                    GoalProgressView()
                }
                .padding()
            }
            .navigationTitle("Dashboard")
        }
    }
}

struct TodaySummaryView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Today's Summary")
                .font(.headline)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Calories In")
                    Text("\(userData.totalCaloriesForToday())")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Calories Out")
                    Text("\(userData.totalCaloriesBurnedForToday())")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            
            ProgressView(value: Double(userData.totalCaloriesForToday()), total: Double(userData.currentUser?.dailyCalorieGoal ?? 2000))
                .accentColor(.blue)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

struct WeeklyProgressView: View {
    // Implement weekly progress chart here
    var body: some View {
        Text("Weekly Progress Chart")
            .padding()
            .frame(height: 200)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
    }
}

struct GoalProgressView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Goal Progress")
                .font(.headline)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Current Weight")
                    Text("\(String(format: "%.1f", userData.currentUser?.weight ?? 0)) kg")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Goal Weight")
                    Text("70.0 kg") // Replace with actual goal weight
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            
            ProgressView(value: 0.7) // Replace with actual progress
                .accentColor(.green)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

                    
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environmentObject(UserData())
//    }
//}

#Preview {
  ContentView().body.environmentObject(UserData())
}
//#Preview{
//MyFitnessApp().body.environmentObject(UserData()) as! any View
//}


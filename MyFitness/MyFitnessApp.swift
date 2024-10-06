//
//  MyFitnessApp.swift
//  MyFitness
//
//  Created by Owner on 10/5/24.
//

import SwiftUI
import SwiftData

@main
struct MyFitnessApp: App {
    @StateObject private var userData = UserData()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData)

        }
        .modelContainer(sharedModelContainer)
    }
}
//#Preview{
//    MyFitnessApp().body.environmentObject(UserData()) as! any View
//}


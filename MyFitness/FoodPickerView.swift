//
//  FoodPickerView.swift
//  MyFitness
//
//  Created by Owner on 10/5/24.
//

import SwiftUI
struct FoodPickerView: View {
    @EnvironmentObject var userData: UserData
    @Binding var selectedFood: FoodItem?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List(userData.foodItems) { food in
                Button(action: {
                    selectedFood = food
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(food.name)
                }
            }
            .navigationTitle("Select Food")
        }
    }
}

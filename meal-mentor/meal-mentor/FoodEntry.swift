//
//  FoodEntry.swift
//  meal-mentor
//
//  Created by Olti Gjoni on 2/10/24.
//

import Foundation

// Define a structure to represent a food entry.
struct FoodEntry: Identifiable {
    var id = UUID()
    var name: String
    var calories: Int
    var date: Date
}


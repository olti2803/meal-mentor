//
//  FoodEntry.swift
//  meal-mentor
//
//  Created by Olti Gjoni on 2/10/24.
//

import Foundation

struct FoodEntry: Identifiable {
    let id = UUID()
    var name: String
    var calories: Int
    var fat: Int
    var protein: Int
    var carb: Int
    var date: Date  // The date the entry was added
}



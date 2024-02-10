//
//  meal_mentorApp.swift
//  meal-mentor
//
//  Created by Olti Gjoni on 2/9/24.
//

import SwiftUI

@main
struct MealMentorApp: App {
    init() {
        // Set the global tint color
        UINavigationBar.appearance().tintColor = UIColor.systemGreen
    }

    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
                .preferredColorScheme(.light)
        }
    }
}

 

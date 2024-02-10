//
//  ContentView.swift
//  meal-mentor
//
//  Created by Olti Gjoni on 2/9/24.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            DailySummaryView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            TrackingView()
                .tabItem {
                    Label("Tracking", systemImage: "list.bullet")
                }
            
            UserProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

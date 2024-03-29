//
//  ContentView.swift
//  meal-mentor
//
//  Created by Olti Gjoni on 2/9/24.
//
import SwiftUI
// "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")


struct ContentView: View {

    
    // Assuming InsightViewModel is your ViewModel for TodaysInsightView
    var insightViewModel = InsightViewModel()

    var body: some View {
       
        TabView {
            // Use TodaysInsightView directly for the Home tab
            TodaysInsightView(viewModel: insightViewModel)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            TrackingView()
                .tabItem {
                    Label("Tracking", systemImage: "list.bullet")
                }
            ChattingView()
                .tabItem {
                    Label("Chat", systemImage: "message")
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

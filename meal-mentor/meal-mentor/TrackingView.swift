//
//  TrackingView.swift
//  meal-mentor
//
//  Created by Olti Gjoni on 2/10/24.
//
import SwiftUI

struct TrackingView: View {
    // State to control navigation
    @State private var isShowingAddEntryView = false

    var body: some View {
        NavigationView {
            List {
                // Your existing tracking list content goes here
                
                // Navigation to AddEntryView
                Button("Add New Entry") {
                    isShowingAddEntryView = true
                }
                .foregroundColor(.blue) // Make the button text blue, or style as you prefer
            }
            .navigationTitle("Tracking")
            // Use .sheet for a modal presentation
            .sheet(isPresented: $isShowingAddEntryView) {
                AddEntryView()
            }
        }
    }
}

struct TrackingView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingView()
    }
}


//
//  TrackingView.swift
//  meal-mentor
//
//  Created by Olti Gjoni on 2/10/24.
//
import SwiftUI

struct TrackingView: View {
    @StateObject private var viewModel = TrackingViewModel()
    @State private var isShowingAddEntryView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.entries) { entry in
                    HStack {
                        Text(entry.name)
                        Spacer()
                        Text("\(entry.calories) kcal")
                    }
                }
                .onDelete(perform: viewModel.deleteEntry)
                
                Button("Add New Entry") {
                    isShowingAddEntryView = true
                }
                .foregroundColor(.blue)
            }
            .navigationTitle("Tracking")
            .sheet(isPresented: $isShowingAddEntryView) {
                AddEntryView(viewModel: viewModel)
            }
        }
    }
}

struct TrackingView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingView()
    }
}

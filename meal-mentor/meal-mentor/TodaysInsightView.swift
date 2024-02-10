//
//  TodaysInsightView.swift
//  meal-mentor
//
//  Created by Olti Gjoni on 2/10/24.
//

import SwiftUI

struct TodaysInsightView: View {
    @StateObject var viewModel = InsightViewModel()

    var body: some View {
        ScrollView { // Use ScrollView in case the content is larger than the screen
            VStack {
                // Logo at the top of the section
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.top)

                // Today's Summary and Advice
                VStack(alignment: .leading) {
                    Text("Today's Insight")
                        .font(.title)
                        .bold()
                    Text(viewModel.dailySummary)
                        .font(.subheadline)
                    Text(viewModel.dailyAdvice)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                
                 Image("Divider") // Replace with the actual name of your image
                     .resizable()
                     .scaledToFit()
                     .frame(height: 100)
                     .frame(width: 350)
                     .padding(5)

                // Calendar view below the summary
                SimpleCalendarView(selectedDate: $viewModel.selectedDate)
                    .padding()

                Spacer() // Use Spacer to push all content to the top
            }
        }
    }
}


// Placeholder ViewModel
class InsightViewModel: ObservableObject {
    @Published var dailySummary = "You've met your goal 5 days in a row!"
    @Published var dailyAdvice = "Great job! Keep up with the veggies and lean proteins."
    @Published var selectedDate = Date()
    //this will have daily insight that is AI generated
}

struct TodaysInsightView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysInsightView(viewModel: InsightViewModel())
    }
}

//
//  DailySummaryView.swift
//  meal-mentor
//
//  Created by Olti Gjoni on 2/10/24.
//

import SwiftUI

struct DailySummaryView: View {
    var body: some View 
    {
        VStack {
            
            Text("Summary and Advice Based on Trends")
                .font(Font.custom("PingFang TC Semibold", size: 15))
                .foregroundColor(.accentColor) // Text color
                .padding() // Padding around the text
                .background(Color.black.opacity(0.1)) // Background color with some transparency
                .cornerRadius(10) // Rounded corners
        }
        .padding() // Padding around the VStack
        
    }
}


struct DailySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        DailySummaryView()
    }
}

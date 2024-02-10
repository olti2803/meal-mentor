//
//  EntryListView.swift
//  meal-mentor
//
//  Created by Olti Gjoni on 2/10/24.
//

import SwiftUI

struct EntryListView: View {
    var entries: [FoodEntry] = [
        FoodEntry(name: "Apple", calories: 95, date: Date()),
        FoodEntry(name: "Banana", calories: 105, date: Date())
    ]

    var body: some View {
        List(entries) { entry in
            HStack {
                VStack(alignment: .leading) {
                    Text(entry.name)
                        .font(.headline)
                        .foregroundColor(.green)
                    Text("Calories: \(entry.calories)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                Text(entry.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 4)
        }
        .listStyle(InsetGroupedListStyle()) // iOS 14+ list style
    }
}


struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView()
    }
}

//
//  TrackingViewModel.swift
//  meal-mentor
//
//  Created by Olti Gjoni on 2/10/24.
//

import Foundation

class TrackingViewModel: ObservableObject {
    @Published var entries: [FoodEntry] = []
    @Published var selectedDate: Date = Date()

    init() {
        // Load existing entries or set up your initial state
        // You might want to load this from persistent storage
        loadEntriesForSelectedDate()
    }

    func addEntry(_ newEntry: FoodEntry) {
        entries.append(newEntry)
        // Save to persistent storage if needed
    }
    
    // Call this method to get entries for a specific date
    func entries(for date: Date) -> [FoodEntry] {
        return entries.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }
    
    // Method to convert daily entries to JSON
    func jsonForEntries(on date: Date) -> String? {
        let dailyEntries = entries(for: date)
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601 // Set the date encoding strategy
        encoder.outputFormatting = .prettyPrinted // Makes the JSON output more readable
        
        do {
            let jsonData = try encoder.encode(dailyEntries)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print("Error encoding entries to JSON: \(error)")
            return nil
        }
    }

    func loadEntriesForSelectedDate() {
        // Filter and load entries for the selected date
        // This will be empty initially if you haven't set up persistence yet
        let startOfDay = Calendar.current.startOfDay(for: selectedDate)
        entries = entries.filter { Calendar.current.isDate($0.date, inSameDayAs: startOfDay) }
    }

    func deleteEntry(at indexSet: IndexSet) {
        entries.remove(atOffsets: indexSet)
        // Update persistent storage if needed
    }
}

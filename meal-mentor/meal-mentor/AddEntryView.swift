//
//  AddEntryView.swift
//  meal-mentor
//
//  Created by Olti Gjoni on 2/10/24.
//
import SwiftUI

struct AddEntryView: View {
    @State private var name: String = ""
    @State private var calories: String = ""
    @State private var protein: String = ""
    @State private var carbs: String = ""
    @State private var fat: String = ""
    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Food Details")) {
                    TextField("Food Name", text: $name)
                    TextField("Calories (kcal)", text: $calories)
                        .keyboardType(.decimalPad)
                    TextField("Protein (g)", text: $protein)
                        .keyboardType(.decimalPad)
                    TextField("Carbs (g)", text: $carbs)
                        .keyboardType(.decimalPad)
                    TextField("Fat (g)", text: $fat)
                        .keyboardType(.decimalPad)
                }
                
                Button("Add Entry") {
                    // Implement the add entry logic here
                    // For example, validate and save the data to your model or database
                }
            }
            .navigationTitle("Add Food Entry")
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Invalid Input"), message: Text("Please fill all fields with valid numbers."), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
    }
}

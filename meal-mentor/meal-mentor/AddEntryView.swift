import SwiftUI

struct AddEntryView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TrackingViewModel

    @State private var name: String = ""
    @State private var calories: String = ""
    @State private var protein: String = ""
    @State private var carbs: String = ""
    @State private var fat: String = ""
    @State private var entryDate: Date = Date() // Add this line for the entry date
    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Food Details")) {
                    TextField("Food Name", text: $name)
                    TextField("Calories (kcal)", text: $calories).keyboardType(.decimalPad)
                    TextField("Protein (g)", text: $protein).keyboardType(.decimalPad)
                    TextField("Carbs (g)", text: $carbs).keyboardType(.decimalPad)
                    TextField("Fat (g)", text: $fat).keyboardType(.decimalPad)
                    DatePicker("Date", selection: $entryDate, displayedComponents: .date) // Add this line for the date picker
                }
                
                Button("Add Entry") {
                    guard let caloriesInt = Int(calories), let proteinInt = Int(protein),
                          let carbsInt = Int(carbs), let fatInt = Int(fat) else {
                        showingAlert = true
                        return
                    }
                    let newEntry = FoodEntry(name: name, calories: caloriesInt, fat: fatInt, protein: proteinInt, carb: carbsInt, date: entryDate)
                    viewModel.addEntry(newEntry)
                    
                    // Dismiss the view after adding the entry
                    presentationMode.wrappedValue.dismiss()
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
        AddEntryView(viewModel: TrackingViewModel())
    }
}

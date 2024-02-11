import SwiftUI

struct UserProfileView: View {
    @State private var name: String = ""
    @State private var weightText: String = ""
    @State private var calorieGoalText: String = ""
    @State private var proteinGoalText: String = ""
    @State private var fatGoalText: String = ""
    @State private var carbsGoalText: String = ""
    @State private var feet: Int = 1
    @State private var inches: Int = 0
    @State private var isProfileCreated: Bool = false
    @State private var createdProfile: Profile?

    var body: some View {
        if isProfileCreated {
            ProfileDetailView(profile: createdProfile!)
        } else {
            VStack {
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                HStack {
                    TextField("Weight lbs", text: $weightText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .frame(width: 100)
                    
                    Text("lbs")
                }
                .padding()
                
                HStack {
                    Picker("Feet", selection: $feet) {
                        ForEach(1...7, id: \.self) { foot in
                            Text("\(foot)")
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 80)
                    
                    Text("feet")
                    
                    Picker("Inches", selection: $inches) {
                        ForEach(0...11, id: \.self) { inch in
                            Text("\(inch)")
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 80)
                    
                    Text("inches")
                }
                .padding()

                TextField("Calorie Goal", text: $calorieGoalText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                
                TextField("Protein Goal (grams)", text: $proteinGoalText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                
                TextField("Fat Goal (grams)", text: $fatGoalText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                
                TextField("Carbs Goal (grams)", text: $carbsGoalText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()

                Button(action: {
                    // Call a function to create profile or perform any other action
                    let weight = Double(weightText) ?? 0
                    let heightInInches = Double(feet * 12 + inches)
                    let calorieGoal = Double(calorieGoalText) ?? 0
                    let proteinGoal = Double(proteinGoalText) ?? 0
                    let fatGoal = Double(fatGoalText) ?? 0
                    let carbsGoal = Double(carbsGoalText) ?? 0
                    let profile = createProfile(name: name, weight: weight, height: heightInInches, calorieGoal: calorieGoal, proteinGoal: proteinGoal, fatGoal: fatGoal, carbsGoal: carbsGoal)
                    print("Created profile: \(profile)")
                    self.isProfileCreated = true
                    self.createdProfile = profile
                }) {
                    Text("Create Profile")
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer()
            }
            .padding()
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

struct Profile {
    var name: String
    var weight: Double
    var height: Double
    var calorieGoal: Double
    var proteinGoal: Double
    var fatGoal: Double
    var carbsGoal: Double
}

func createProfile(name: String, weight: Double, height: Double, calorieGoal: Double, proteinGoal: Double, fatGoal: Double, carbsGoal: Double) -> Profile {
    let newProfile = Profile(name: name, weight: weight, height: height, calorieGoal: calorieGoal, proteinGoal: proteinGoal, fatGoal: fatGoal, carbsGoal: carbsGoal)
    return newProfile
}

struct ProfileDetailView: View {
    var profile: Profile
    
    var body: some View {
        VStack {
            Text("Name: \(profile.name)")
            Text("Weight: \(profile.weight) lbs")
            Text("Height: \(Int(profile.height / 12)) feet \(Int(profile.height) % 12) inches")
            Text("Calorie Goal: \(profile.calorieGoal)")
            Text("Protein Goal: \(profile.proteinGoal) grams")
            Text("Fat Goal: \(profile.fatGoal) grams")
            Text("Carbs Goal: \(profile.carbsGoal) grams")
        }
        .padding()
    }
}

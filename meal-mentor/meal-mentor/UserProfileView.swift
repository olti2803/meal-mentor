//
//  UserProfileView.swift
//  meal-mentor
//
//  Created by Olti Gjoni on 2/10/24.
//
import SwiftUI

struct UserProfileView: View {
    @State private var name: String = ""
    @State private var weightText: String = "0" // String for typed weight
    @State private var feet: Int = 1
    @State private var inches: Int = 0
    @State private var calorieGoalText: String = "0" // String for typed calorie goal
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
                
                TextField("Weight lbs", text: $weightText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
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
                    .padding()

                Button(action: {
                    // Call a function to create profile or perform any other action
                    let weight = Double(weightText) ?? 0
                    let heightInInches = Double(feet * 12 + inches)
                    let calorieGoal = Double(calorieGoalText) ?? 0
                    let profile = createProfile(name: name, weight: Int(weight), height: Int(heightInInches), calorieGoal: Int(calorieGoal))
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
    var weight: Int
    var height: Int
    var calorieGoal: Int
}

func createProfile(name: String, weight: Int, height: Int, calorieGoal: Int) -> Profile {
    let newProfile = Profile(name: name, weight: weight, height: height, calorieGoal: calorieGoal)
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
        }
        .padding()
    }
}



//
//  UserProfileView.swift
//  meal-mentor
//
//  Created by Olti Gjoni on 2/10/24.
//
import SwiftUI

struct UserProfileView: View {
    @State private var name: String = ""
    @State private var weight: String = ""
    @State private var height: String = ""

    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Weight", text: $weight)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.numberPad) // Set keyboard type to number pad
            TextField("Height", text: $height)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.numberPad) // Set keyboard type to number pad

            Button(action: {
                // Call a function to create profile or perform any other action
                let profile = createProfile(name: name, weight: Double(weight) ?? 0, height: Double(height) ?? 0)
                print("Created profile: \(profile)")
            }) {
                Text("Create Profile")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
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
}

func createProfile(name: String, weight: Double, height: Double) -> Profile {
    let newProfile = Profile(name: name, weight: weight, height: height)
    return newProfile
}

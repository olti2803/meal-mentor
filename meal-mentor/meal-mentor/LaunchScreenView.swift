//
//  LaunchScreenView.swift
//  meal-mentor
//
//  Created by Olti Gjoni on 2/10/24.
//
    //
    //        VStack {
    //            Image("Logo")
    //                .resizable()
    //                .scaledToFit()
    //                .frame(width: 400, height: 400) // Adjust the size as needed
    //
    //            Text("Meal Mentor") // Optional: App name or tagline
    //                .font(.system(size: 50, weight: .bold))
    //                .foregroundColor(.primary)
    //        }
    //        .edgesIgnoringSafeArea(.all) // Make the launch screen full screen
    //    }
    //PingFang TC Semibold

    import SwiftUI

    struct LaunchScreenView: View {
        @State var isActive : Bool = false
        @State private var size = 0.8
        @State private var opacity = 0.5
        
        // Customise your SplashScreen here
        var body: some View {
            if isActive {
                ContentView()
            } else {
                VStack {
                    VStack {
                        Image("Logo")
                            .font(.system(size: 80))
                            .foregroundColor(.red)
                        Text("Meal Mentor")
                            .font(Font.custom("PingFang TC Semibold", size: 40))
                            .foregroundColor(.black.opacity(0.80))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.00
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }

    struct LaunchScreenView_Previews: PreviewProvider {
        static var previews: some View {
            LaunchScreenView()
        }
    }

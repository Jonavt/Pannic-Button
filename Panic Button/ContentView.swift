//
//  ContentView.swift
//  Panic Button
//
//  Created by UDLAP14 on 07/03/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @EnvironmentObject var navVM: NavigationViewModel
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            if hasCompletedOnboarding {
                HomeView()
                    .transition(.opacity.animation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 3)))
            } else {
                NavigationStack {
                    RegisterView()
                        .transition(.opacity.animation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 3)))
                }
            }
        }
//        .onAppear {
//            hasCompletedOnboarding = false
//        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NavigationViewModel())
    }
}

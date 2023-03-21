//
//  Panic_ButtonApp.swift
//  Panic Button
//
//  Created by UDLAP14 on 07/03/23.
//

import SwiftUI

@main
struct Panic_ButtonApp: App {
    let navigationViewModel = NavigationViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationViewModel)
        }
    }
}

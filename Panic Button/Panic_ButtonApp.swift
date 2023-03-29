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
    let locationViewModel = LocationViewModel()
    let contactsViewModel = ContactsViewModel()
    let dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(navigationViewModel)
                .environmentObject(locationViewModel)
                .environmentObject(contactsViewModel)
        }
    }
}

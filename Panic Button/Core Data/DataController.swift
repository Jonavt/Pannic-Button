//
//  DataController.swift
//  Panic Button
//
//  Created by Arturo Diaz on 3/29/23.
//

import SwiftUI
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Contacts")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}

func buttonVibration(intensity: CGFloat = 0.7) {
    let generator = UIImpactFeedbackGenerator()
    generator.impactOccurred(intensity: intensity)
}

func successVibration() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
}

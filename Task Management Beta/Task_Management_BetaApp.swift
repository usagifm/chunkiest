//
//  Task_Management_BetaApp.swift
//  Task Management Beta
//
//  Created by Muhammad Nur Faqqih on 21/06/22.
//

import SwiftUI

@main
struct Task_Management_BetaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

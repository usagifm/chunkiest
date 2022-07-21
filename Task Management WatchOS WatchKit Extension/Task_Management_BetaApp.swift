//
//  Task_Management_BetaApp.swift
//  Task Management WatchOS WatchKit Extension
//
//  Created by Jauza Krito on 18/07/22.
//

import SwiftUI

@main
struct Task_Management_BetaApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(progress: 0.4)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}

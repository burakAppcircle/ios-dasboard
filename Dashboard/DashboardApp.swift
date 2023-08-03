//
//  DashboardApp.swift
//  Dashboard
//
//  Created by Mustafa on 17.08.2022.
//Danger test 4
//Commit account change
//dangerfile created
import SwiftUI

@main
struct DashboardApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

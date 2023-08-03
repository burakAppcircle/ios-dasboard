//
//  DashboardApp.swift
//  Dashboard
//
//  Created by Mustafa on 17.08.2022.
//Danger test 4

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

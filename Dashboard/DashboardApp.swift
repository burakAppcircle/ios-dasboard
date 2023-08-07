//
//  DashboardApp.swift
//  Dashboard
//
//  Created by Mustafa on 17.08.2022.
//  Danger with SwiftLint
//  extensions changed
//  azure push

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

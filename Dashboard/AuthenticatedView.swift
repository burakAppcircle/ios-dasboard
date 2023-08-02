//
//  AuthenticatedView.swift
//  Dashboard
//
//  Created by Mustafa on 19.08.2022.
//

import Foundation
import SwiftUI

struct AuthenticatedView: View {
    
    var body: some View {
        TabView {
            BuildProfilesView()
                .tabItem {
                    Label("Profiles", systemImage: "hammer.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct AuthenticatedView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticatedView()
    }
}

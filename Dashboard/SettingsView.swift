//
//  SettingsView.swift
//  Dashboard
//
//  Created by Mustafa on 17.08.2022.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var vm = LoginViewModel()

    var body: some View {
        VStack {
            Text("Settings")
            TextEditor(text: $vm.pat)
                .foregroundColor(.secondary)
                .padding(.horizontal)

//            Button("Clear") {
//               vm.logoutUser()
//            }
            .padding()
            .frame(width: 100, height: 40, alignment: .center)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
        }

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

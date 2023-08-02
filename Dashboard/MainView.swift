//
//  MainView.swift
//  Dashboard
//
//  Created by Mustafa on 17.08.2022.
//

import SwiftUI

struct MainView: View {
    @State var isAuthenticated =  AuthManager.IsAuthenticated()
        
    var body: some View {
        Group {
            isAuthenticated ?
            AnyView(AuthenticatedView())   :
            AnyView(LoginView())
        }.onReceive(AuthManager.Authenticated, perform: {
            isAuthenticated = $0
        })
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

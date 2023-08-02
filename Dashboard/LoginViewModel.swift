//
//  LoginViewModel.swift
//  Dashboard
//
//  Created by Mustafa on 19.08.2022.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var pat = ""
    var errorMessage = ""
}

extension LoginViewModel {
    func logoutUser() {
        UserDefaults.standard.removeObject(forKey: "pat")
        UserDefaults.standard.removeObject(forKey: "token")
        AuthManager.Authenticated.send(false)
    }
    func loginUser() -> Bool {
            UserDefaults.standard.set(pat, forKey: "pat")
            AuthManager.Authenticated.send(true)
            return true
    }
}

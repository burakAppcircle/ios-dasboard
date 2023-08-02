//
//  AuthManager.swift
//  Dashboard
//
//  Created by Mustafa on 19.08.2022.
//

import Foundation
import Combine

public struct Token {
    /// Personal Access Token
    var pat:String
    /// Bearer Token
    var accesstoken: String?
    /// Is token valid?
    var isValid: Bool {
        return true
    }
    
    public init(pat : String , accesstoken : String? = nil) {
        self.pat = pat
        self.accesstoken = accesstoken
    }
}

enum AuthError: Error {
    case missingToken
    case invalidToken
}

actor AuthManager {
    static let Authenticated = PassthroughSubject<Bool, Never>()
    private var currentToken: Token?
    private var refreshTask: Task<Token, Error>?
    private var store : TokenStore
    
    public init(store : TokenStore = UserDefaultsStore()) {
        self.store = store
        self.currentToken = store.get(key: "token")
    }
    
    static func isAuthenticated() -> Bool {
        print("Is Authenticated")
        return UserDefaults.standard.string(forKey: "pat") != nil
    }
    
    
    /// Refresh access token with
    /// - Parameter pat: Personal Access Tokken
    /// - Returns: Fresh Token
    func refreshToken() async throws -> Token {
        if let refreshTask = refreshTask {
            return try await refreshTask.value
        }

        let task = Task { () throws -> Token in
            defer { refreshTask = nil }

            if let pat = currentToken?.pat {
                // Normally you'd make a network call here. Could look like this:
                // return await networking.refreshToken(withRefreshToken: token.refreshToken)

                // I'm just generating a dummy token
                let newToken = Token(pat: "pat")
                currentToken = newToken

                return newToken
            } else {
                throw AuthError.missingToken
            }
        }

        self.refreshTask = task
        return try await task.value
    }
    
    func validToken() async throws -> Token {
        // if there's a refresh task get its value
        if let handle = refreshTask {
            return try await handle.value
        }
        // No token object ? It means we don't have PAT in the storage
        guard let token = currentToken else {
            throw AuthError.missingToken
        }

        if token.isValid {
            return token
        }
        return try await refreshToken() // token.pat
    }

}

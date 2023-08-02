//
//  TokenManager.swift
//  Dashboard
//
//  Created by Mustafa on 1.09.2022.
//  Copyright © 2022 Appcircle Inc. All rights reserved.
//

import Foundation

public protocol TokenStore {
    func get(key:String) -> Token?
    func set(key:String,value:Token) throws
}


class UserDefaultsStore: TokenStore {
    func get(key: String) -> Token? {
        if let pat = UserDefaults.standard.string(forKey: "pat") {
            let accesstoken = UserDefaults.standard.string(forKey: "access_token")
            let token = Token(pat: pat, accesstoken: accesstoken)
            return token
        }
        return nil
    }
    
    func set(key: String, value: Token) throws {
        print("OK!")
    }
    
}


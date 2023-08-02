//
//  Networking.swift
//  Dashboard
//
//  Created by Mustafa on 19.08.2022.
//

import Foundation

public enum ContentType: String {
    case applicationJson = "application/json"
}

public enum AppcircleAPI {
    case buildprofiles(page:Int)
    case me
    
    public var endpoint:Endpoint {
        switch self {
        case let .buildprofiles(page):
            return Endpoint(httpMethod: .get, path: "/build/v1/profiles?page=\(page)&size=24", headers: [:], parameters: nil)
        case .me:
            return Endpoint(httpMethod: .get, path: "/license/v1/licenses/current", headers: [:], parameters: nil)

        }
    }
}

public struct Endpoint {
    var path: String
    var httpMethod: HTTPMethod
    var parameters: [String: String]?
    var headers: [String: String]

    public init(httpMethod: HTTPMethod = .get, path:String, headers: [String: String],parameters:[String: String]?) {
        self.path = path
        self.httpMethod = httpMethod
        self.headers = headers
        self.parameters = parameters
    }
}


public enum HTTPMethod:String{
    case get = "GET"
    case post = "POST"
//    case put = "PUT"
//    case head = "HEAD"
//    case delete = "DELETE"
//    case patch = "PATCH"
//    case options = "OPTIONS"
//    case connect = "CONNECT"
//    case trace = "TRACE"
}

enum RequestError: Error {
    case invalidUrl
}

class Networking {

    let authManager: AuthManager
    let baseURL = "https://api.appcircle.io"
    let authURL =  "https://auth.appcircle.io"
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    static let shared = Networking(authManager: AuthManager())

    
    func loadAuthorized<T: Decodable>(_ url: URL, allowRetry: Bool = true) async throws -> T {
        let request = try await authorizedRequest(from: url)
        let (data, urlResponse) = try await URLSession.shared.data(for: request)

        // check the http status code and refresh + retry if we received 401 Unauthorized
        if let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.statusCode == 401 {
            if allowRetry {
                _ = try await authManager.refreshToken()
                return try await loadAuthorized(url, allowRetry: false)
            }

            throw AuthError.invalidToken
        }

        let decoder = JSONDecoder()
        let response = try decoder.decode(T.self, from: data)

        return response
    }
    
    func loadAuthorized<T: Decodable>(_ endpint: Endpoint, allowRetry: Bool = true) async throws -> T {
        let request = try await authorizedRequest(from: endpint)
        let (data, urlResponse) = try await URLSession.shared.data(for: request)

        // check the http status code and refresh + retry if we received 401 Unauthorized
        if let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.statusCode == 401 {
            if allowRetry {
                _ = try await authManager.refreshToken()
                return try await loadAuthorized(endpint, allowRetry: false)
            }

            throw AuthError.invalidToken
        }

        let decoder = JSONDecoder()
        let response = try decoder.decode(T.self, from: data)

        return response
    }

    
    func login(token:String) {
        
    }
    
    private func post(from:Endpoint) async throws -> URLRequest {
        guard let url = URL(string: baseURL + from.path)
        else {
            throw RequestError.invalidUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = from.httpMethod.rawValue
        if let body = from.parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        return request
    }
    
    private func get(from: Endpoint) async throws -> URLRequest {
        guard let url = URL(string: baseURL + from.path),
              var components = URLComponents(url: url, resolvingAgainstBaseURL: url.baseURL != nil)
        else {
            throw RequestError.invalidUrl
        }
        if let parameters = from.parameters {
            let queryItems = parameters.map { URLQueryItem(name: $0, value: $1)}
            components.queryItems = queryItems
        }
        let request = URLRequest(url:components.url!)
        return request
    }
    
    private func authorizedRequest(from url: URL) async throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        let token = try await authManager.validToken()
        if let access_token = token.access_token {
            urlRequest.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
        }
        return urlRequest
    }
    
    private func authorizedRequest(from endpoint: Endpoint) async throws -> URLRequest {
        var urlRequest:URLRequest
        switch endpoint.httpMethod {
        case .get:
            urlRequest = try await self.get(from: endpoint)
        case .post:
            urlRequest = try await self.get(from: endpoint)
        }
        
        let token = try await authManager.validToken()
        if let access_token = token.access_token {
            urlRequest.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
        }
        return urlRequest
    }

}

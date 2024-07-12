//
//  Endpoints.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 10/07/2024.
//

import Foundation

enum users {
    case users_list
    case user_me_read
}

enum auth {
    case login
    case register
}

enum Endpoints {
    static var baseURL: String = "https://drf-boilerplate-2k96.onrender.com/api"

    case users(users)
    case auth(auth)

    private var api: String {
        switch self {
            case .users(let user):
                switch user {
                    case .users_list:
                        return "/users/"
                    case .user_me_read:
                        return "/users/me/"
                }
            case .auth(let auth):
                switch auth {
                    case .login:
                        return "/auth/login/"
                    case .register:
                        return "/auth/register"
                }
        }
    }

    static func getEndpoint(_ endpoint: Endpoints) -> String {
        return baseURL + endpoint.api
    }
}

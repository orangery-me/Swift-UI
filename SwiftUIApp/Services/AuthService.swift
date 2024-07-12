//
//  AuthService.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 10/07/2024.
//

import Foundation
import SwiftKeychainWrapper

private enum KeychainKeys {
    static let accessToken: String = "User.accessToken"
    static let refreshToken: String = "User.refreshToken"
}

struct Credential {
    var accessToken: String?
    var refreshToken: String?
}

final class AuthService: ObservableObject {
    @Published var isLogged: Bool = false
    static let share = AuthService()

    private init() {
        isLogged = hasAccessToken()
    }

    func getCredentials() -> Credential {
        return Credential(
            accessToken: KeychainWrapper.standard.string(forKey: KeychainKeys.accessToken),
            refreshToken: KeychainWrapper.standard.string(forKey: KeychainKeys.accessToken)
        )
    }

    func setCredentials(accessToken: String, refreshToken: String) {
        KeychainWrapper.standard.set(accessToken, forKey: KeychainKeys.accessToken)
        KeychainWrapper.standard.set(refreshToken, forKey: KeychainKeys.refreshToken)
    }

    func getAccessToken() -> String? {
        return getCredentials().accessToken
    }

    func getRefreshToken() -> String? {
        return getCredentials().refreshToken
    }

    func hasAccessToken() -> Bool {
        return getAccessToken() != nil
    }

    func logout() {
        KeychainWrapper.standard.removeObject(forKey: KeychainKeys.accessToken)
        KeychainWrapper.standard.removeObject(forKey: KeychainKeys.refreshToken)
        DispatchQueue.main.async {
            self.isLogged = false
        }
    }
}

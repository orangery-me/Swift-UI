//
//  AuthService.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 10/07/2024.
//

import Foundation
import SimpleKeychain

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
    let simpleKeyChain: SimpleKeychain = .init(service: "Auth")
    static let share = AuthService()

    private init() {
        isLogged = hasAccessToken()
    }

    func getCredentials() -> Credential {
        do {
            let accessToken = try simpleKeyChain.string(forKey: KeychainKeys.accessToken)
            let refreshToken = try simpleKeyChain.string(forKey: KeychainKeys.refreshToken)
            return Credential(
                accessToken: accessToken,
                refreshToken: refreshToken
            )
        } catch {
            print(error)
            return Credential()
        }
    }

    func setCredentials(accessToken: String, refreshToken: String) {
        do {
            try simpleKeyChain.set(accessToken, forKey: KeychainKeys.accessToken)
            try simpleKeyChain.set(refreshToken, forKey: KeychainKeys.refreshToken)
        } catch {
            print(error)
        }
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
        do {
            try simpleKeyChain.deleteItem(forKey: KeychainKeys.accessToken)
            try simpleKeyChain.deleteItem(forKey: KeychainKeys.refreshToken)
            DispatchQueue.main.async {
                self.isLogged = false
            }
        } catch {
            print(error)
        }
    }
}

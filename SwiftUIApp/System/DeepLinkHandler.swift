//
//  DeepLinkHandler.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 13/07/2024.
//

import Foundation

enum DeepLink: Equatable {
    case routeTo(destination: String, parameters: [String: String])

    init?(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
              let host = components.host,
              let queryItems = components.queryItems else { return nil }

        let parameters = queryItems.reduce(into: [String: String]()) { dict, item in
            dict[item.name] = item.value
        }
        self = .routeTo(destination: host, parameters: parameters)
    }
}

// MARK: - DeepLinksHandler

protocol DeepLinksHandler {
    func open(deepLink: DeepLink)
}

struct RealDeepLinksHandler: DeepLinksHandler {
    private let container: DIContainer

    init(container: DIContainer) {
        self.container = container
    }

    func open(deepLink: DeepLink) {
        switch deepLink {
            case let .routeTo(destination, parameters):
                handleRoute(destination: destination, parameters: parameters)
        }
    }

    func handleRoute(destination: String, parameters: [String: String]) {}
}

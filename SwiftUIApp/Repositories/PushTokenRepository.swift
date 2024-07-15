//
//  PushTokenRepository.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 13/07/2024.
//

import Combine
import Foundation

protocol PushTokenWebRepository: WebRepository {
    func register(devicePushToken: Data) -> AnyPublisher<Void, Error>
}

struct RealPushTokenWebRepository: PushTokenWebRepository {
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")

    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }

    func register(devicePushToken: Data) -> AnyPublisher<Void, Error> {
        // upload the push token to your server
        return Just<Void>.withErrorType(Error.self)
    }
}

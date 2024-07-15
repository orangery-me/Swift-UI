//
//  UserRepository.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 13/07/2024.
//

import Combine
import Foundation

protocol UserWebRepository: WebRepository {
    func loadAllUsers() -> AnyPublisher<UsersPerPage, Error>
    func loadUserDetail(user: UserResponse) -> AnyPublisher<UserResponse, Error>
}

struct UserRepository: UserWebRepository {
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")

    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }

    func loadAllUsers() -> AnyPublisher<UsersPerPage, Error> {
        return call(endpoint: API.allUsers)
    }

    func loadUserDetail(user: UserResponse) -> AnyPublisher<UserResponse, Error> {
        return call(endpoint: API.userDetail)
    }
}

// MARK: - Endpoints

extension UserRepository {
    enum API {
        case userDetail
        case allUsers
    }
}

extension UserRepository.API: APICall {
    var path: String {
        switch self {
            case .allUsers:
                return "/users/"
            case .userDetail:
                return "/users/me/"
        }
    }

    var method: String {
        switch self {
            case .allUsers, .userDetail:
                return "GET"
        }
    }

    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }

    func body() throws -> Data? {
        return nil
    }
}

//
//  UserResponse.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 11/07/2024.
//

import Foundation

struct UserResponse: Codable {
    var id: Int
    var name: String
    var email: String
    var role: Role

    init(id: Int, name: String, email: String, role: Role) {
        self.id = id
        self.name = name
        self.email = email
        self.role = role
    }

    init() {
        self.id = 0
        self.name = ""
        self.email = ""
        self.role = .defaultRole
    }`
}

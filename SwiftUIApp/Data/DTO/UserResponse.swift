//
//  UserResponse.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 11/07/2024.
//

import Foundation

struct UserResponse: Codable, Identifiable {
    var id: Int
    var name: String
    var email: String
    var role: Role

    init(id: Int = 0, name: String = "Chau Thi", email: String = "thi@gmail.com", role: Role = Role()) {
        self.id = id
        self.name = name
        self.email = email
        self.role = role
    }
}

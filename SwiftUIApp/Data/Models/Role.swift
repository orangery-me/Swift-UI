//
//  Role.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 11/07/2024.
//

import Foundation

struct Role: Codable {
    var id: Int
    var name: String
    init(id: Int = 0, name: String = "") {
        self.id = id
        self.name = name
    }
}

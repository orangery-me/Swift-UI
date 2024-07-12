//
//  UserList.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 12/07/2024.
//

import Foundation

struct UserList: Decodable {
    var next: String?
    var previous: String?
    var results: [UserResponse]
}

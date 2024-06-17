//
//  LoginResponse.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 15/06/2024.
//

import Foundation

struct LoginResponse : Decodable{
    var accessToken : String
    var refreshToken : String
    
}

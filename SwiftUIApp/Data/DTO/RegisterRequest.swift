//
//  RegisterRequest.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 29/06/2024.
//

import Foundation

struct RegisterRequest : Encodable{
    var name : String
    var email : String
    var role : Int
    var password : String
}

//
//  CallAPIError.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 18/06/2024.
//

import Foundation
enum CallAPIError : Error{
    case RequestTimeOut
    case APIRequestFailed
    case EnableToEncode
    case EnableToDecode
}

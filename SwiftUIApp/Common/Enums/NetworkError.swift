//
//  CallAPIError.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 18/06/2024.
//

import Foundation

enum NetworkError: Error {
    case RequestTimeOut
    case APIRequestFailed
    case InternalError
    case EnableToEncode
    case EnableToDecode
}

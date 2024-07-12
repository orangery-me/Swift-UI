//
//  NetworkHelper.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 11/07/2024.
//

import Foundation

enum NetworkHelper {
    static func post<T: Encodable>(param: T, path: String, _ completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) {
        let url = URL(string: path)

        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let token = AuthService.share.getAccessToken() {
            urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        }

        guard let decodedBody = try? JSONEncoder().encode(param) else {
            return
        }
        urlRequest.httpBody = decodedBody

        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: completionHandler)
        task.resume()
    }

    static func get(path: String, params: [String: String]? = [:], _ completionHandler: @escaping @Sendable (Data?, URLResponse?) -> Void) async throws {
        var urlComponents = URLComponents(string: path)!

        if let params = params {
            urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        var urlRequest = URLRequest(url: urlComponents.url!)

        if let token = AuthService.share.getAccessToken() {
            urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        completionHandler(data, response)
    }
}

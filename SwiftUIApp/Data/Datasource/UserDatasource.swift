//
//  UserDatasource.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 15/06/2024.
//

import Foundation

struct UserDatasource {
    func register(param: RegisterRequest, path: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        NetworkHelper.post(param: param, path: path) { data, response, _ in
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 201 {
                    completion(.failure(.APIRequestFailed))
                }
            }
            do {
                let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data!)
                completion(.success(()))
            }
            catch {
                completion(.failure(.EnableToDecode))
            }
        }
    }
    
//    func loginByEmail(param: LoginRequest, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
//        let url = URL(string: "https://drf-boilerplate-2k96.onrender.com/api/auth/login/")
//
//        var urlRequest = URLRequest(url: url!)
//        urlRequest.httpMethod = "POST"
//        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        guard let decodedBody = try? JSONEncoder().encode(param) else {
//            completion(.failure(.EnableToEncode))
//            return
//        }
//
//        urlRequest.httpBody = decodedBody
//
//        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, _ in
//
//            if let response = response as? HTTPURLResponse {
//                if response.statusCode != 200 {
//                    completion(.failure(.APIRequestFailed))
//                }
//            }
//
//            print("data: \(String(describing: String(data: data!, encoding: .utf8)))")
//            do {
//                let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data!)
//                completion(.success(decodedResponse))
//            }
//            catch {
//                completion(.failure(.EnableToDecode))
//            }
//
//        })
//        task.resume()
//    }
    
    func login(param: LoginRequest, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
        NetworkHelper.post(param: param, path: "https://drf-boilerplate-2k96.onrender.com/api/auth/login/") { data, response, _ in
                
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    completion(.failure(.APIRequestFailed))
                }
            }
            print("data: \(String(describing: String(data: data!, encoding: .utf8)))")
            do {
                let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data!)
                completion(.success(decodedResponse))
            }
            catch {
                completion(.failure(.EnableToDecode))
            }
        }
    }
    
    func getUserInfo(completion: @escaping (Result<UserResponse, NetworkError>) -> Void) async {
        do {
            try await NetworkHelper.get(path: "https://drf-boilerplate-2k96.onrender.com/users/me/") { data, response in
                if let response = response as? HTTPURLResponse {
                    if response.statusCode != 200 {
                        completion(.failure(.APIRequestFailed))
                    }
                }
                print("data: \(String(describing: String(data: data!, encoding: .utf8)))")
                do {
                    let decodedResponse = try JSONDecoder().decode(UserResponse.self, from: data!)
                    completion(.success(decodedResponse))
                }
                catch {
                    completion(.failure(.EnableToDecode))
                }
            }
        }
        catch {
            completion(.failure(.APIRequestFailed))
        }
    }
}

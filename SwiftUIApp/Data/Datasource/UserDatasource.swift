//
//  UserDatasource.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 15/06/2024.
//

import Foundation

struct UserDatasource {
    func register(param: RegisterRequest, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let path = Endpoints.getEndpoint(.auth(.register))
        NetworkHelper.post(param: param, path: path) { data, response, _ in
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 201 {
                    completion(.failure(.APIRequestFailed))
                }
            }
            do {
                _ = try JSONDecoder().decode(LoginResponse.self, from: data!)
                completion(.success(()))
            }
            catch {
                completion(.failure(.EnableToDecode))
            }
        }
    }
    
    func login(param: LoginRequest, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
        let path = Endpoints.getEndpoint(.auth(.login))
        NetworkHelper.post(param: param, path: path) { data, response, _ in
                
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
        let path = Endpoints.getEndpoint(.users(.user_me_read))
        do {
            try await NetworkHelper.get(path: path) { data, response in
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
                    print(error)
                    completion(.failure(.EnableToDecode))
                }
            }
        }
        catch {
            completion(.failure(.APIRequestFailed))
        }
    }
    
    func getUsers(completion: @escaping (Result<UserList, NetworkError>) -> Void) async {
        let path = Endpoints.getEndpoint(.users(.users_list))
        do {
            try await NetworkHelper.get(path: path, params: ["limit": "10", "offset": "0"]) { data, response in
                if let response = response as? HTTPURLResponse {
                    if response.statusCode != 200 {
                        completion(.failure(.APIRequestFailed))
                    }
                }
                print("data: \(String(describing: String(data: data!, encoding: .utf8)))")
                do {
                    let decodedResponse = try JSONDecoder().decode(UserList.self, from: data!)
                    completion(.success(decodedResponse))
                }
                catch {
                    print(error)
                    completion(.failure(.EnableToDecode))
                }
            }
        }
        catch {
            completion(.failure(.APIRequestFailed))
        }
    }
}

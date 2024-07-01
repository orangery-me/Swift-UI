//
//  UserDatasource.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 15/06/2024.
//

import Foundation
struct UserDatasource{
    
    func register(param : RegisterRequest, completion: @escaping (Result<Void, CallAPIError>) -> Void ){
        guard let url = URL(string: "https://drf-boilerplate-2k96.onrender.com/api/auth/register/") else{
            completion(.failure(.APIRequestFailed))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let decodedBody = try? JSONEncoder().encode(param) else{
            completion(.failure(.EnableToEncode))
            return
        }
        
        urlRequest.httpBody = decodedBody
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            if let error = error as? NSError{
                if error.code == NSURLErrorTimedOut{
                    completion(.failure(.RequestTimeOut))
                }
            }
            
            print((String(describing: data) + " " + String(describing: response)) )
            if let response = response as? HTTPURLResponse{
                if (response.statusCode != 201){
                    completion(.failure(.APIRequestFailed))
                }
            }
        })
        
        task.resume()
    }
    
    func loginByEmail(param : LoginRequest, completion: @escaping (Result<LoginResponse, CallAPIError>) -> Void) {
        guard let url = URL(string: "https://drf-boilerplate-2k96.onrender.com/api/auth/login/") else {
            completion(.failure(.APIRequestFailed))
            return
        }
        var urlRequest =  URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let decodedBody = try? JSONEncoder().encode(param) else{
            completion(.failure(.EnableToEncode))
            return
        }
        
        urlRequest.httpBody = decodedBody
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response , error in
            
            if let response = response as? HTTPURLResponse{
                if (response.statusCode != 200){
                    completion(.failure(.APIRequestFailed))
                }
            }
            
            guard let data = data else{
                completion(.failure(.APIRequestFailed))
                return
            }
            
            print("data: \(String(describing: String(data: data, encoding: .utf8)))")
            do{
                let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                completion(.success(decodedResponse))
            }
            catch{
                completion(.failure(.EnableToDecode))
            }
            
        })
        task.resume()
    }
}

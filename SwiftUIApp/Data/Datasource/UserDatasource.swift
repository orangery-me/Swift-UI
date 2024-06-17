//
//  UserDatasource.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 15/06/2024.
//

import Foundation
struct UserDatasource{
    func loginByEmail(param : LoginRequest) async throws -> LoginResponse{
        guard let url = URL(string: "https://drf-boilerplate-2k96.onrender.com/api/auth/login") else { return <#default value#> }
        var urlRequest =  URLRequest(url: url)
        urlRequest.httpMethod = "post"
        
        try await URLSession.shared.dataTask(with: urlRequest, completionHandler: { data,_, error in
            // unwrap optinals
            if let data = data {
                let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                // unwrap optinals
                if let response = response{
                    
                }else{
                    // unale to decode to json. Response is nil
                    
                }
                
            }else{
                // api request failed. Data is nil
                
            }
        })
    }
}

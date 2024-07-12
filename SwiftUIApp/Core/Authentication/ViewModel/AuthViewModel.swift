//
//  AuthViewModel.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 10/07/2024.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var isSuccess: Bool = false
    @Published var didFail: Bool = false
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false

    func register() {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        UserDatasource().register(
            param: RegisterRequest(name: name, email: email, role: 1, password: password),
            completion: { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                        case .success:
                            self?.isLoading = false
                            self?.isSuccess = true
                        case .failure(let error):
                            self?.isLoading = false
                            self?.errorMessage = error.localizedDescription
                            self?.didFail = true
                            print(error.localizedDescription)
                    }
                }
            }
        )
    }

    func login() {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        UserDatasource().login(
            param: LoginRequest(email: email, password: password),
            completion: { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                        case .success(let response):
                            self?.isLoading = false
                            self?.isSuccess = true
                            AuthService.share.setCredentials(accessToken: response.access, refreshToken: response.refresh)
                        case .failure(let error):
                            self?.didFail = true
                            self?.errorMessage = error.localizedDescription
                            self?.isLoading = false
                    }
                }
            }
        )
    }
}

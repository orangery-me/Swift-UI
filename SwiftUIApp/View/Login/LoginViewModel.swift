//
//  LoginViewModel.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 14/06/2024.
//

import Foundation
class LoginViewModel : ObservableObject{
    @Published var email : String = ""
    @Published var password: String = ""
    @Published var isSuccess: Bool = false
    @Published var didFail: Bool = false
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    func login() {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        UserDatasource().loginByEmail(
            param: LoginRequest(email: email, password: password),
            completion: { [weak self] result in
            DispatchQueue.main.async {
                switch (result){
                        case .success:
                            self?.isLoading = false
                            self?.isSuccess = true
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

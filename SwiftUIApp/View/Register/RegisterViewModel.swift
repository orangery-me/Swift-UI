//
//  RegisterViewModel.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 01/07/2024.
//

import Foundation

class RegisterViewModel : ObservableObject{
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var name : String = ""
    @Published var isLoading : Bool = false
    @Published var isSuccess : Bool = false
    @Published var errorMessage : String = ""
    @Published var didFail : Bool = false
    
    func register(){
        DispatchQueue.main.async {
            self.isLoading = true
        }
        UserDatasource().register(
            param: RegisterRequest(name: name, email: email, role: 1, password: password),
            completion: { [weak self] result in
            DispatchQueue.main.async {
                switch (result){
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
        })
    }
}

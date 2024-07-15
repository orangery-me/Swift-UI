//
//  SettingViewModel.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 12/07/2024.
//

import Foundation

class SettingViewModel: ObservableObject {
    @Published var myUser: UserResponse = .init()
    @Published var users: [UserResponse] = []
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false

    func getMyUser() async {
        await UserDatasource().getUserInfo { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                        
                    case .success(let response):
                        self.myUser = response
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        print(error.localizedDescription)
                }
            }
        }
    }

    func getUsers() async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        await UserDatasource().getUsers { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        self.users = response.results
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        print(error.localizedDescription)
                }
                self.isLoading = false
            }
        }
    }
}

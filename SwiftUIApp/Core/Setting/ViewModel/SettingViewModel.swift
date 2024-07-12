//
//  SettingViewModel.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 12/07/2024.
//

import Foundation

class SettingViewModel: ObservableObject {
    @Published var myUser: UserResponse = .init()
    @Published var errorMessage: String = ""

    func getMyUser() async {
        await UserDatasource().getUserInfo { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        self.myUser = response
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

//
//  UserInteractor.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 15/07/2024.
//

import Combine
import Foundation

protocol UserService {
    func refreshUsersList() -> AnyPublisher<Void, Error>
    func loadUsers(users: LoadableSubject<UsersPerPage>, search: String)
    func loadUserDetails(userDetails: LoadableSubject<UserResponse>, user: UserResponse)
}

struct RealUserService: UserService {
    let webRepository: UserWebRepository
    let appState: Store<AppState>
    
    init(webRepository: UserWebRepository, appState: Store<AppState>) {
        self.webRepository = webRepository
        self.appState = appState
    }
    
    func refreshUsersList() -> AnyPublisher<Void, Error> {
        return webRepository
            .loadAllUsers()
            .map { _ in () }
            .eraseToAnyPublisher()
    }
    
    func loadUsers(users: LoadableSubject<UsersPerPage>, search: String) {
        let cancelBag = CancelBag()
        users.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
        webRepository
            .loadAllUsers()
            .sinkToLoadable { users.wrappedValue = $0 }
            .store(in: cancelBag)
    }
    
    func loadUserDetails(userDetails: LoadableSubject<UserResponse>, user: UserResponse) {
        let cancelBag = CancelBag()
        userDetails.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
        webRepository
            .loadUserDetail(user: user)
            .sinkToLoadable { userDetails.wrappedValue = $0 }
            .store(in: cancelBag)
    }
}

struct StubUserService: UserService {
    func refreshUsersList() -> AnyPublisher<Void, Error> {
        return Just<Void>.withErrorType(Error.self)
    }
    
    func loadUsers(users: LoadableSubject<UsersPerPage>, search: String) {}
    
    func loadUserDetails(userDetails: LoadableSubject<UserResponse>, user: UserResponse) {}
}

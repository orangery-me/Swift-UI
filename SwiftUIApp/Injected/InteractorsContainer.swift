//
//  InteractorsContainer.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 13/07/2024.
//

import Foundation

extension DIContainer {
    struct Interactors {
        let imagesInteractor: ImagesService
        let userPermissionsInteractor: UserPermissionsInteractor
        let userInteractor: UserService

        init(imagesInteractor: ImagesService, userPermissionsInteractor: UserPermissionsInteractor, userInteractor: UserService) {
            self.imagesInteractor = imagesInteractor
            self.userPermissionsInteractor = userPermissionsInteractor
            self.userInteractor = userInteractor
        }

        static var stub: Self {
            .init(
                imagesInteractor: StubImagesService(),
                userPermissionsInteractor: StubUserPermissionsInteractor(),
                userInteractor: StubUserService()
            )
        }
    }
}

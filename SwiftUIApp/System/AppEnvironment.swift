//
//  AppEnvironment.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 13/07/2024.
//

import Combine
import UIKit

class AppEnvironment: ObservableObject {
    let container: DIContainer
    let systemEventsHandler: SystemEventsHandler
    
    init(container: DIContainer, systemEventsHandler: SystemEventsHandler) {
        self.container = container
        self.systemEventsHandler = systemEventsHandler
    }
    
    static func bootstrap() -> AppEnvironment {
        let appState = Store<AppState>(AppState())
        /*
         To see the deep linking in action:
         
         1. Launch the app in iOS 13.4 simulator (or newer)
         2. Subscribe on Push Notifications with "Allow Push" button
         3. Minimize the app
         4. Drag & drop "push_with_deeplink.apns" into the Simulator window
         5. Tap on the push notification
         
         Alternatively, just copy the code below before the "return" and launch:
         
         DispatchQueue.main.async {
         deepLinksHandler.open(deepLink: .showCountryFlag(alpha3Code: "AFG"))
         }
         */
        let session = configuredURLSession()
        let webRepositories = configuredWebRepositories(session: session)
        let interactors = configuredInteractors(appState: appState,
                                                webRepositories: webRepositories)
        let diContainer = DIContainer(appState: appState, interactors: interactors)
        let deepLinksHandler = RealDeepLinksHandler(container: diContainer)
        let pushNotificationsHandler = RealPushNotificationsHandler(deepLinksHandler: deepLinksHandler)
        let systemEventsHandler = RealSystemEventsHandler(
            container: diContainer, deepLinksHandler: deepLinksHandler,
            pushNotificationsHandler: pushNotificationsHandler,
            pushTokenWebRepository: webRepositories.pushTokenWebRepository)
        return AppEnvironment(container: diContainer,
                              systemEventsHandler: systemEventsHandler)
    }
}

extension AppEnvironment {
    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
    
    private static func configuredWebRepositories(session: URLSession) -> DIContainer.WebRepositories {
        let imageWebRepository = RealImageWebRepository(
            session: session,
            baseURL: "https://ezgif.com")
        let pushTokenWebRepository = RealPushTokenWebRepository(
            session: session,
            baseURL: "https://fake.backend.com")
        let userRepository = UserRepository(
            session: session,
            baseURL: "https://drf-boilerplate-2k96.onrender.com/api")
        return .init(imageRepository: imageWebRepository,
                     pushTokenWebRepository: pushTokenWebRepository,
                     userRepository: userRepository)
    }
    
    private static func configuredInteractors(appState: Store<AppState>,
                                              webRepositories: DIContainer.WebRepositories) -> DIContainer.Interactors
    {
        let imagesInteractor = RealImagesService(
            webRepository: webRepositories.imageRepository)
        
        let userPermissionsInteractor = RealUserPermissionsInteractor(
            appState: appState, openAppSettings: {
                URL(string: UIApplication.openSettingsURLString).flatMap {
                    UIApplication.shared.open($0, options: [:], completionHandler: nil)
                }
            })
        let userInteractor = RealUserService(
            webRepository: webRepositories.userRepository,
            appState: appState)
        
        return .init(
            imagesInteractor: imagesInteractor,
            userPermissionsInteractor: userPermissionsInteractor,
            userInteractor: userInteractor)
    }
}

extension DIContainer {
    struct WebRepositories {
        let imageRepository: ImageWebRepository
        let pushTokenWebRepository: PushTokenWebRepository
        let userRepository: UserRepository
    }
}

//
//  RootView.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 11/07/2024.
//

import EnvironmentOverrides
import SwiftUI

struct RootView: View {
    @EnvironmentObject var authService: AuthService
    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            if authService.isLogged {
                HomeView().navigationBarHidden(true)
            } else {
                LoginView()
            }
        }
    }
}

extension RootView {
    class ViewModel: ObservableObject {
        let container: DIContainer
        let isRunningTests: Bool

        init(container: DIContainer, isRunningTests: Bool = ProcessInfo.processInfo.isRunningTests) {
            self.container = container
            self.isRunningTests = isRunningTests
        }

        var onChangeHandler: (EnvironmentValues.Diff) -> Void {
            return { diff in
                if !diff.isDisjoint(with: [.locale, .sizeCategory]) {
                    self.container.appState[\.routing] = AppState.ViewRouting()
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModel: RootView.ViewModel(container: .preview)).environmentObject(AuthService.share)
    }
}

// namcao@example.com

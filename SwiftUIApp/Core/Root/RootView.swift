//
//  RootView.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 11/07/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authService: AuthService

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

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView().environmentObject(AuthService.share)
    }
}

// namcao@example.com

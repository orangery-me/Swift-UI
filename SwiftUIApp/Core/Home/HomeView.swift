//
//  HomeView.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 20/06/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var authService: AuthService

    var body: some View {
        TabView {
            VStack {
                Text("Hello")
                Button("Logout") {
                    print("test logout")
                    authService.logout()
                }
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            SettingView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Setting")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//
//  SettingView.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 02/07/2024.
//

import SwiftUI

struct SettingView: View {
    @State var isAccountTab: Bool = true

    var body: some View {
        NavigationView {
            VStack {
                // settings sections and items will go here
                HStack(alignment: .center) {
                    Spacer()
                    Text("Account")
                        .foregroundColor(isAccountTab ? .accentColor : .black)
                        .fontWeight(isAccountTab ? .bold : .medium)
                        .onTapGesture {
                            isAccountTab.toggle()
                        }
                    Spacer()
                    Text("Users")
                        .foregroundColor(isAccountTab ? .black : .accentColor)
                        .fontWeight(isAccountTab ? .medium : .bold)
                        .onTapGesture {
                            isAccountTab.toggle()
                        }
                    Spacer()
                }
                Divider()
                if isAccountTab {
                    ProfileView()
                } else {
                    UsersView()
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Settings")
        }
    }
}

struct UsersView: View {
    @ObservedObject var settingVM: SettingViewModel = .init()

    var body: some View {
        Group {
            if settingVM.isLoading {
                ProgressView()
            } else {
                List(settingVM.users) { user in
                    HStack {
                        Image(systemName: "person")
                        VStack(alignment: .leading) {
                            Text(user.name)
                            Text(user.email).font(.custom("body", size: 14))
                        }
                        Spacer()
                    }
                }
            }
        }.onAppear {
            Task {
                await settingVM.getUsers()
            }
        }
    }
}

struct ProfileView: View {
    @ObservedObject var settingVM: SettingViewModel = .init()

    var body: some View {
        VStack {
            HStack {
                Text("Profile").fontWeight(.bold)
                Spacer()
                Button("Edit") {}
                    .buttonBorderShape(.roundedRectangle(radius: 20))
            }.padding()
            VStack(alignment: .leading) {
                Text("Name")
                TextField("Ed Sheeran", text: $settingVM.myUser.name)
                    .padding()
                    .background(.black.opacity(0.1))
                    .cornerRadius(8)
            }
            VStack(alignment: .leading) {
                Text("Email")
                TextField("email@example.com", text: $settingVM.myUser.email)
                    .padding()
                    .background(.black.opacity(0.1))
                    .cornerRadius(8)
            }
        }.onAppear {
            Task {
                await settingVM.getMyUser()
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

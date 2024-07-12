//
//  LoginView.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 14/06/2024.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: AuthViewModel = .init()

    var body: some View {
        HStack {
            VStack {
                Text("Welcome back!")
                    .font(.largeTitle)
                    .bold()
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background(.black.opacity(0.1))
                    .cornerRadius(10.0)
                    .padding(.horizontal, 30)
                    .keyboardType(.emailAddress)
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(.black.opacity(0.1))
                    .cornerRadius(10.0)
                    .padding(.horizontal, 30)
                HStack {
                    Spacer()
                    NavigationLink("Forget Password?", destination: {}).padding(.horizontal, 30)
                }
                if viewModel.isLoading {
                    RoundedButton(
                        buttonContent:
                        ProgressView() // Show loading indicator
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5), // Optional: Scale the spinner,
                        action: {})
                } else {
                    RoundedButton(
                        buttonContent: Text("Log in"),
                        action: viewModel.login)
                }
                HStack {
                    Text("Don't have an account yet?")
                    NavigationLink(
                        "Sign up",
                        destination: RegisterView())
                }
            }.navigationDestination(isPresented: $viewModel.isSuccess, destination: {
                HomeView().navigationBarHidden(true)
            })
        }.alert("Username or password is incorrect!", isPresented: $viewModel.didFail) {}
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

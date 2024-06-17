//
//  LoginView.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 14/06/2024.
//

import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        HStack {
            NavigationView{
                VStack{
                    Text("Welcome back!")
                        .font(.largeTitle)
                        .bold()
                    TextField("Username", text: $username)
                        .padding()
                        .background(.black.opacity(0.1))
                        .cornerRadius(10.0)
                        .padding(.horizontal, 30)
                    SecureField("Password", text: $password)
                        .padding()
                        .background(.black.opacity(0.1))
                        .cornerRadius(10.0)
                        .padding(.horizontal, 30)
                    HStack{
                        Spacer()
                        NavigationLink("Forget Password?", destination: {}).padding(.horizontal, 30)
                    }
                    Button("Login"){
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(.blue)
                    .cornerRadius(10.0)
                    .padding()
                    HStack{
                        Text("Don't have an account yet?")
                        NavigationLink("Sign up", destination: {})
                    }
                    
                }
            }.navigationBarHidden(true)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

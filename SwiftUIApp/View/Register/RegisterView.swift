//
//  RegisterView.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 20/06/2024.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var registerViewModel : RegisterViewModel = RegisterViewModel()
    @State var retype_password : String = ""
    @Environment(\.dismiss) private var dismiss
    
    func retypePasswordCheck(_ password : String, _ retype_password : String) -> Bool{
        return password == retype_password
    }
    
    var body: some View {
        HStack{
            NavigationStack{
                VStack{
                    Text("Sign up")
                        .font(.largeTitle)
                        .bold()
                    TextField("Name", text: $registerViewModel.name)
                        .padding()
                        .background(.black.opacity(0.1))
                        .cornerRadius(10.0)
                        .padding(.horizontal, 30)
                    TextField("Email", text: $registerViewModel.email)
                        .padding()
                        .background(.black.opacity(0.1))
                        .cornerRadius(10.0)
                        .padding(.horizontal, 30)
                    SecureField("Password", text: $registerViewModel.password)
                        .padding()
                        .background(.black.opacity(0.1))
                        .cornerRadius(10.0)
                        .padding(.horizontal, 30)
                    SecureField("Re-type password", text: $retype_password)
                        .padding()
                        .background(.black.opacity(0.1))
                        .cornerRadius(10.0)
                        .padding(.horizontal, 30)
                    if (!retypePasswordCheck(registerViewModel.password, retype_password)){
                        Text("Retype password is incorrect")
                    }
                    if registerViewModel.isLoading {
                        RoundedButton(
                            buttonContent:
                                ProgressView() // Show loading indicator
                                .progressViewStyle(CircularProgressViewStyle())
                                .scaleEffect(1.5), // Optional: Scale the spinner,
                            action: {})
                    }
                    else{
                        RoundedButton(
                            buttonContent: Text("Sign up"),
                            action: registerViewModel.register
                        )
                    }
                    HStack{
                        Text("Already have an account?")
                        Button("Log in") {
                            dismiss()
                        }
                    }
                }.navigationBarHidden(true)
                    .navigationDestination(isPresented: $registerViewModel.isSuccess, destination: {LoginView()})
            }.alert("Email or Password is not valid", isPresented: $registerViewModel.didFail, actions: {})
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

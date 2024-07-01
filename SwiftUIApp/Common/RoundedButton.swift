//
//  RoundedButton.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 28/06/2024.
//

import SwiftUI

struct RoundedButton<Content : View>: View {
    var buttonContent : Content
    var action : () -> Void
    
    var body: some View {
        Button(action: action){
            buttonContent
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.blue)
            .cornerRadius(10.0)
            .padding()
        }
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(buttonContent: Text("Content"), action: {print("Button clicked")})
    }
}

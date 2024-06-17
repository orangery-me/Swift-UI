//
//  CircleImage.swift
//  WeatherApp
//
//  Created by Chau Thi on 31/05/2024.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("preview")
            .resizable()
            .scaledToFit()
            .frame(width: 300)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(.black, lineWidth: 4)
            )
            .shadow(radius: 12.0)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}

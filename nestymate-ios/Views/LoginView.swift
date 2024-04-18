//
//  LoginView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 18/4/24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        Text("Hello, World!")
            .font(FontManager.title)
            .foregroundStyle(.yellow)
        Button {
            print("logging in")
        } label: {
            Text("Hello, World!")
                .font(FontManager.button)
                .foregroundStyle(ColorManager.buttonTextColour)
        }
        .buttonStyle(.bordered)
        .background(ColorManager.buttonBackgroundColour)

    }
}

#Preview {
    LoginView()
}

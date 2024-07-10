//
//  LoginView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 18/4/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel = .init()
    struct Output {
        var goToMainScreen: () -> Void
        var goToCreateHome: () -> Void
    }

    var output: Output
    var body: some View {
        VStack {
            Text("login").font(FontManager.title)
            SingleTextField(title: "Username", value: Binding<String>(
                get: { self.viewModel.username ?? "" },
                set: { self.viewModel.username = $0 }))
            SingleTextField(title: "Password", value: Binding<String>(
                get: { self.viewModel.password ?? "" },
                set: { self.viewModel.password = $0 }))
            ActionButton(title: "login") {
                // viewModel.username
                // viewModel.password
                viewModel.login(username: "test123", password: "test321") {
                    viewModel.checkHomeForUser { home in
                        home == nil ? self.output.goToCreateHome() : self.output.goToMainScreen()
                    }
                }
            }
            HStack {
                Text("New to Nestymate?").font(FontManager.button)
                Button {} label: {
                    Text("Sign up here")
                        .foregroundColor(ColorManager.linkColour)
                        .underline()
                        .font(FontManager.button)
                }
            }
            Spacer()
        }
        .padding([.top], 64)
        .background(ColorManager.backgroundColour)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    LoginView(output: LoginView.Output(goToMainScreen: {}, goToCreateHome: {}))
}

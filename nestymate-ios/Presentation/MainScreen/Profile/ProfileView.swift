//
//  ProfileView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import SwiftUI

struct ProfileView: View {
    var viewModel: ProfileViewModel = .init()
    struct Output {
        var goToLogin: () -> Void
    }

    var output: Output
    var body: some View {
        ActionButton(title: "Logout", shouldEnableButton: true) {
            viewModel.logout {
                self.output.goToLogin()
            }
        }
    }
}

#Preview {
    ProfileView(output: ProfileView.Output(goToLogin: {}))
}

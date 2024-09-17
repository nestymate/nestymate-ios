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
        var goToInviteUser: () -> Void
    }

    var output: Output
    var body: some View {
        VStack {
            Spacer()
            ActionButton(title: "Logout", shouldEnableButton: true) {
                viewModel.logout {
                    self.output.goToLogin()
                }
            }

            ActionButton(title: "Invite User", shouldEnableButton: true) {
                viewModel.logout {
                    self.output.goToInviteUser()
                }
            }
            Spacer()
            
        }
        .padding()
        .background(ColorManager.backgroundColour)
    }
}

#Preview {
    ProfileView(output: ProfileView.Output(goToLogin: {}, goToInviteUser: {}))
}

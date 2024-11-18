//
//  InviteUserView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import SwiftUI

struct InviteUserView: View {
    @ObservedObject var viewModel: InviteUserViewModel
    struct Output {
        var goBack: () -> Void
        var logout: () -> Void
    }

    var output: Output
    var body: some View {
        VStack {
            Text(String(localized: "invite_user")).font(FontManager.title)
            SingleTextField(fieldModel: $viewModel.email)
            ActionButton(
                title: String(localized: "invite"),
                shouldEnableButton: viewModel.shouldEnableButton
            ) {
                viewModel.inviteUser { shouldLogout in
                    guard let shouldLogout, !shouldLogout else { return output.logout() }
                    output.goBack()
                }
            }
            Spacer()
        }
        .background(ColorManager.backgroundColour)
    }
}

#Preview {
    InviteUserView(
        viewModel: InviteUserViewModel(useCase: HomeUseCaseImpl(homeService: HomeServiceImpl())),
        output: InviteUserView.Output(goBack: {}, logout: {})
    )
}

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
    }

    var output: Output
    var body: some View {
        VStack {
            Text("Invite User").font(FontManager.title)
            SingleTextField(fieldModel: $viewModel.email)
                .onSubmit {
                    _ = viewModel.email.onSubmitError()
                }
            ActionButton(
                title: "Invite",
                shouldEnableButton: viewModel.shouldEnableButton
            ) {
                viewModel.inviteUser {
                    self.output.goBack()
                }
            }
            Spacer()
        }
        .background(ColorManager.backgroundColour)
    }
}

#Preview {
    InviteUserView(viewModel: InviteUserViewModel(), output: InviteUserView.Output(goBack: {}))
}

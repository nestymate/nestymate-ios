//
//  InviteUserView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import SwiftUI

struct InviteUserView: View {
    @ObservedObject var viewModel: InviteUserViewModel
    @State private var showSuccessAlert = false
    struct Output {
        var goBack: () -> Void
        var logout: () -> Void
    }

    var output: Output
    var body: some View {
        ActivityIndicatorIView(isShowing: Binding<Bool>(
            get: { viewModel.shouldShowLoader ?? false },
            set: { viewModel.shouldShowLoader = $0 }
        )) {
            VStack {
                Text(String(localized: "invite_user")).font(FontManager.title)
                SingleTextField(fieldModel: $viewModel.email)
                ActionButton(
                    title: String(localized: "invite"),
                    shouldEnableButton: viewModel.shouldEnableButton
                ) {
                    Task {
                        let success = try await viewModel.inviteUser()
                        if success {
                            showSuccessAlert = true
                        }
                    }
                }
                Spacer()
            }
            .alert(String(localized: "Invite sent"), isPresented: $showSuccessAlert) {
                Button("OK", role: .cancel) {
                    output.goBack()
                }
            }
            .alert(item: $viewModel.error) { error in
                handleHttpErrorAlert(error: error) {
                    output.logout()
                }
            }
            .background(ColorManager.backgroundColour)
        }
    }
}

#Preview {
    InviteUserView(
        viewModel: InviteUserViewModel(useCase: HomeUseCaseImpl(homeService: HomeServiceImpl())),
        output: InviteUserView.Output(goBack: {}, logout: {})
    )
}

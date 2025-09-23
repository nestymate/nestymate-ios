//
//  CreateOrEditHomeView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//

import SwiftUI

struct CreateOrEditHomeView: View {
    @ObservedObject var viewModel: CreateOrEditHomeViewModel
    @State private var viewDidLoad = false
    struct Output {
        var goToMainScreen: () -> Void
        var goBack: () -> Void
        var logout: () -> Void
    }

    var output: Output
    var body: some View {
        ActivityIndicatorIView(isShowing: Binding<Bool>(
            get: { viewModel.shouldShowLoader ?? false },
            set: { viewModel.shouldShowLoader = $0 }
        )) {
            ScrollView {
                VStack {
                    Text(viewModel.pageTitle).font(FontManager.title)
                    SingleTextField(fieldModel: $viewModel.name)
                    SingleTextField(fieldModel: $viewModel.description)
                    SingleTextField(fieldModel: $viewModel.address)
                    if viewModel.isEdit {
                        Toggle(isOn: $viewModel.active) {
                            Text("Current Home")
                        }
                        .padding(PaddingManager.normalPadding)
                    }
                    ActionButton(
                        title: viewModel.buttonTitle,
                        shouldEnableButton: viewModel.shouldEnableButton
                    ) {
                        Task {
                            let success = try await viewModel.createOrEditHome()
                            if success {
                                if viewModel.isEdit {
                                    output.goBack()
                                } else {
                                    output.goToMainScreen()
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
            .background(ColorManager.backgroundColour)
            .alert(item: $viewModel.error) { error in
                handleHttpErrorAlert(error: error) {
                    output.logout()
                }
            }
            .onAppear {
                Task {
                    await viewModel.getHome()
                }
            }
        }
    }
}

#Preview {
    CreateOrEditHomeView(viewModel: CreateOrEditHomeViewModel(
        useCase: HomeUseCaseImpl(homeService: HomeServiceImpl()), homeId: 0
    ), output: CreateOrEditHomeView.Output(
        goToMainScreen: {},
        goBack: {},
        logout: {}
    ))
}

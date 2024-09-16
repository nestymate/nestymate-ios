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
        var logout: () -> Void
    }

    var output: Output
    var body: some View {
        ActivityIndicatorIView(isShowing: Binding<Bool>(
            get: { self.viewModel.shouldShowLoader ?? false },
            set: { self.viewModel.shouldShowLoader = $0 }
        )) {
            ScrollView {
                VStack {
                    Text(viewModel.pageTitle).font(FontManager.title)
                    SingleTextField(fieldModel: $viewModel.name)
                        .onSubmit {
                            _ = viewModel.name.onSubmitError()
                        }
                    SingleTextField(fieldModel: $viewModel.description)
                        .onSubmit {
                            _ = viewModel.description.onSubmitError()
                        }
                    SingleTextField(fieldModel: $viewModel.address)
                        .onSubmit {
                            _ = viewModel.address.onSubmitError()
                        }
                    ActionButton(
                        title: viewModel.buttonTitle,
                        shouldEnableButton: viewModel.shouldEnableButton
                    ) {
                        viewModel.createHome { shouldLogout in
                            guard let shouldLogout, !shouldLogout else { return self.output.logout() }
                            self.output.goToMainScreen()
                        }
                    }
                    Spacer()
                }
            }
            .background(ColorManager.backgroundColour)
            .alert(item: $viewModel.error) { error in
                error.alert
            }
            .onAppear {
                if viewDidLoad == false && viewModel.isEdit {
                    viewDidLoad = true
                    viewModel.getHome()
                }
            }
        }
    }
}

#Preview {
    CreateOrEditHomeView(viewModel: CreateOrEditHomeViewModel(
        useCase: HomeUseCaseImpl(homeService: HomeServiceImpl()), isEdit: true
    ),
    output: CreateOrEditHomeView.Output(goToMainScreen: {}, logout: {}))
}

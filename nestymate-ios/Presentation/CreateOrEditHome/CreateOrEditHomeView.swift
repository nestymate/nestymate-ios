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
            get: { viewModel.shouldShowLoader ?? false },
            set: { viewModel.shouldShowLoader = $0 }
        )) {
            ScrollView {
                VStack {
                    Text(viewModel.pageTitle).font(FontManager.title)
                    SingleTextField(fieldModel: $viewModel.name)
                    SingleTextField(fieldModel: $viewModel.description)
                    SingleTextField(fieldModel: $viewModel.address)
                    ActionButton(
                        title: viewModel.buttonTitle,
                        shouldEnableButton: viewModel.shouldEnableButton
                    ) {
                        viewModel.createOrEditHome { shouldLogout in
                            guard !shouldLogout else { return output.logout() }
                            output.goToMainScreen()
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
                if viewDidLoad == false, viewModel.isEdit {
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

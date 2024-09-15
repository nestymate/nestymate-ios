//
//  CreateHomeView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//

import SwiftUI

struct CreateHomeView: View {
    @ObservedObject var viewModel: CreateHomeViewModel
    struct Output {
        var goToMainScreen: () -> Void
    }

    var output: Output
    var body: some View {
        ActivityIndicatorIView(isShowing: Binding<Bool>(
            get: { self.viewModel.shouldShowLoader ?? false },
            set: { self.viewModel.shouldShowLoader = $0 }
        )) {
            ScrollView {
                VStack {
                    Text("New Home").font(FontManager.title)
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
                        title: "Create",
                        shouldEnableButton: viewModel.shouldEnableButton
                    ) {
                        viewModel.createHome {
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
        }
    }
}

#Preview {
    CreateHomeView(viewModel: CreateHomeViewModel(
        useCase: CreateHomeUseCaseImpl(service: HomeServiceImpl())),
    output: CreateHomeView.Output(goToMainScreen: {}))
}

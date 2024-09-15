//
//  CreateOrEditExpenseView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation
import SwiftUI

struct CreateOrEditExpenseView: View {
    @ObservedObject var viewModel: CreateOrEditExpenseViewModel
    @State private var viewDidLoad = false
    struct Output {
        var goBack: () -> Void
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
                    SingleTextField(fieldModel: $viewModel.title)
                        .onSubmit {
                            _ = viewModel.title.onSubmitError()
                        }
                    SingleTextField(fieldModel: $viewModel.description)
                        .onSubmit {
                            _ = viewModel.description.onSubmitError()
                        }
                    SingleTextField(fieldModel: $viewModel.amount)
                        .onSubmit {
                            _ = viewModel.amount.onSubmitError()
                        }
                    ActionButton(
                        title: viewModel.buttonTitle,
                        shouldEnableButton: viewModel.shouldEnableButton
                    ) {
                        viewModel.createOrUpdateExpense {
                            self.output.goBack()
                        }
                    }
                    Spacer()
                }
            }
            .hiddenNavigationBarStyle()
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

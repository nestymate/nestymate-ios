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
                    SingleTextField(fieldModel: $viewModel.title)
                    SingleTextField(fieldModel: $viewModel.description)
                    SingleTextField(fieldModel: $viewModel.amount)

                    ActionButton(
                        title: viewModel.buttonTitle,
                        shouldEnableButton: viewModel.shouldEnableButton
                    ) {
                        viewModel.createOrUpdateExpense { shouldLogout in
                            guard let shouldLogout, !shouldLogout
                            else { return self.output.logout() }
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
    CreateOrEditHomeView(viewModel: CreateOrEditHomeViewModel(
        useCase: HomeUseCaseImpl(homeService: HomeServiceImpl()), isEdit: true
    ),
    output: CreateOrEditHomeView.Output(goToMainScreen: {}, logout: {}))
}

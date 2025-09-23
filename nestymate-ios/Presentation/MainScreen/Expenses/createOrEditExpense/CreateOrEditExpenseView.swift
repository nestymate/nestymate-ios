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
            get: { viewModel.shouldShowLoader ?? false },
            set: { viewModel.shouldShowLoader = $0 }
        )) {
            ScrollView {
                VStack {
                    Text(viewModel.pageTitle).font(FontManager.title)
                    usersPicker
                    categoryPicker
                    SingleTextField(fieldModel: $viewModel.title)
                    SingleTextField(fieldModel: $viewModel.description)
                    DatePickerUIView(title: String(localized: "date"), fieldModel: $viewModel.date)
                    SingleTextField(fieldModel: $viewModel.amount)

                    ActionButton(
                        title: viewModel.buttonTitle,
                        shouldEnableButton: viewModel.shouldEnableButton
                    ) {
                        Task {
                            let success = try await viewModel.createOrUpdateExpense()
                            if success {
                                output.goBack()
                            }
                        }
                    }
                    Spacer()
                }
            }
            .hiddenNavigationBarStyle()
            .background(ColorManager.backgroundColour)
            .alert(item: $viewModel.error) { error in
                handleHttpErrorAlert(error: error) {
                    output.logout()
                }
            }
            .onAppear {
                Task {
                    try await viewModel.getExpense()
                }
            }
        }
    }
}

extension CreateOrEditExpenseView {
    var categoryPicker: some View {
        Picker(viewModel.categoryTitle, selection: $viewModel.selectedCategory) {
            ForEach(viewModel.categories, id: \.self) { category in
                Text(category.name).tag(Optional(category))
            }
        }
    }

    var usersPicker: some View {
        Picker(viewModel.usersTitle, selection: $viewModel.selectedUser) {
            ForEach(viewModel.users, id: \.self) { user in
                Text(user.username).tag(Optional(user))
            }
        }
    }
}

#Preview {
    CreateOrEditExpenseView(viewModel: CreateOrEditExpenseViewModel(
        expenseId: 0,
        useCase: ExpenseUseCaseImpl(
            service: ExpenseServiceImpl()
        ), homeUseCase: HomeUseCaseImpl(homeService: HomeServiceImpl()),
        categoryUseCase: CategoryUseCaseImpl(service: CategoryServiceImpl()),
        logoutService: LogoutService()
    ),
    output: CreateOrEditExpenseView.Output(goBack: {}, logout: {}))
}

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
    @State private var selectedCategory: Int?
    @FocusState private var focusItem: Bool
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
                    categoryPicker
                    SingleTextField(fieldModel: $viewModel.title)
                    SingleTextField(fieldModel: $viewModel.description)
                    SingleTextField(fieldModel: $viewModel.amount)
                        .focused($focusItem)

                    ActionButton(
                        title: viewModel.buttonTitle,
                        shouldEnableButton: viewModel.shouldEnableButton
                    ) {
                        viewModel.createOrUpdateExpense(expenseCategoryId: selectedCategory) { shouldLogout in
                            guard let shouldLogout, !shouldLogout
                            else { return self.output.logout() }
                            self.output.goBack()
                        }
                    }
                    Spacer()
                }
            }
            .onTapGesture {
                focusItem = false
            }
            .hiddenNavigationBarStyle()
            .background(ColorManager.backgroundColour)
            .alert(item: $viewModel.error) { error in
                error.alert
            }
            .onAppear {
                viewModel.getCategories { selectedCategory, shouldLogout in
                    self.selectedCategory = selectedCategory
                    guard !shouldLogout else { return output.logout() }
                }
            }
        }
    }
}

extension CreateOrEditExpenseView {
    var categoryPicker: some View {
        Picker(viewModel.categoryTitle, selection: $selectedCategory) {
            ForEach(viewModel.categories, id: \.self) { category in
                Text(category.name).tag(category.id)
            }
        }
    }
}

#Preview {
    CreateOrEditExpenseView(viewModel: CreateOrEditExpenseViewModel(
        expenseId: 0,
        useCase: ExpenseUseCaseImpl(
            service: ExpenseServiceImpl()
        ), categoryUseCase: CategoryUseCaseImpl(service: CategoryServiceImpl()),
        logoutService: LogoutService()
    ),
    output: CreateOrEditExpenseView.Output(goBack: {}, logout: {}))
}

//
//  CreateOrEditExpenseViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

class CreateOrEditExpenseViewModel: ObservableObject {
    private let useCase: ExpenseUseCase
    private let categoryUseCase: CategoryUseCase
    private let logoutService: LogoutService
    var categoryTitle = String(localized: "category")
    @Published var categories: [Category] = []
    @Published var title: FieldModel = .init(value: "", fieldType: .name)
    @Published var description: FieldModel = .init(value: "", fieldType: .description)
    @Published var amount: FieldModel = .init(value: "", fieldType: .amount)
    @Published var shouldShowLoader: Bool?
    @Published var isEdit: Bool = false
    @Published var error: Error?
    var buttonTitle: String = ""
    var pageTitle: String = ""
    private var expense: Expense?

    init(
        expense: Expense?,
        useCase: ExpenseUseCase,
        categoryUseCase: CategoryUseCase,
        logoutService: LogoutService
    ) {
        isEdit = expense != nil
        self.expense = expense
        self.useCase = useCase
        self.categoryUseCase = categoryUseCase
        self.logoutService = logoutService
        setupExpense()
        setupTitles()
    }

    var shouldEnableButton: Bool {
        !title.value.isEmpty && !description.value.isEmpty && !amount.value.isEmpty
    }

    func setupExpense() {
        guard isEdit, let expense else { return }
        title = .init(value: expense.title ?? "''", fieldType: .name)
        description = .init(value: expense.description, fieldType: .description)
        amount = .init(value: String(expense.amount), fieldType: .amount)
    }

    public func getCategories(completionHandler: @escaping (Int?, Bool) -> Void) {
        shouldShowLoader = true
        categoryUseCase.getCategories { [weak self] categories, error, statusCode in
            guard let self else { return }
            self.categories = categories ?? []
            self.shouldShowLoader = false
            self.error = error
            if isEdit {
                // get correct here
                completionHandler(5, logoutService.shouldLogout(statusCode: statusCode))
            } else {
                completionHandler(nil, logoutService.shouldLogout(statusCode: statusCode))
            }
        }
    }

    func createOrUpdateExpense(expenseCategoryId: Int?, completionHandler: @escaping (Bool?) -> Void) {
        if useCase.createValid(
            isTitleValid: title.onValidate(),
            isDescriptionValid: description.onValidate(),
            isAmountValid: amount.onValidate(),
            hasSelectedCategory: expenseCategoryId != nil
        ) {
            shouldShowLoader = true
            let amountInDouble = Double(amount.value) ?? 0.0
            let expense = Expense(
                id: expense?.id ?? 0,
                title: title.value,
                description: description.value,
                amount: amountInDouble
            )
            let expenseCategoryId = expenseCategoryId ?? 0
            if isEdit {
                useCase.editExpense(expense: expense) { [weak self] error, statusCode in
                    self?.shouldShowLoader = false
                    self?.error = error
                    completionHandler(self?.logoutService.shouldLogout(statusCode: statusCode))
                }
            } else {
                useCase.createExpense(
                    expenseCategoryId: expenseCategoryId,
                    expense: expense
                ) { [weak self] error, statusCode in
                    self?.shouldShowLoader = false
                    self?.error = error
                    completionHandler(self?.logoutService.shouldLogout(statusCode: statusCode))
                }
            }
        }
    }

    private func setupTitles() {
        buttonTitle = isEdit ? String(localized: "update") : String(localized: "save")
        pageTitle = isEdit ? String(localized: "edit_expense") : String(localized: "create_expense")
    }
}

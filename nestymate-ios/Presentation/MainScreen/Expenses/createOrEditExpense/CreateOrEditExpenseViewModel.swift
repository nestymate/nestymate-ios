//
//  CreateOrEditExpenseViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

class CreateOrEditExpenseViewModel: ObservableObject {
    private let useCase: ExpenseUseCase
    private let logoutService: LogoutService
    @Published var title: FieldModel = .init(value: "", fieldType: .name)
    @Published var description: FieldModel = .init(value: "", fieldType: .description)
    @Published var amount: FieldModel = .init(value: "", fieldType: .amount)
    @Published var shouldShowLoader: Bool?
    @Published var isEdit: Bool = false
    @Published var error: Error?
    var buttonTitle: String = ""
    var pageTitle: String = ""
    private var expense: Expense?

    init(expense: Expense?, useCase: ExpenseUseCase, logoutService: LogoutService) {
        isEdit = expense != nil
        self.expense = expense
        self.useCase = useCase
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

    func createOrUpdateExpense(completionHandler: @escaping (Bool?) -> Void) {
        if useCase.createValid(
            isTitleValid: title.onValidate(),
            isDescriptionValid: description.onValidate(),
            isAmountValid: amount.onValidate()
        ) {
            shouldShowLoader = true
            let amountInDouble = Double(amount.value) ?? 0.0
            let expense = Expense(
                title: title.value,
                description: description.value,
                amount: amountInDouble
            )
            if isEdit {
                useCase.editExpense(expense: expense) { [weak self] error, statusCode in
                    self?.shouldShowLoader = false
                    self?.error = error
                    completionHandler(self?.logoutService.shouldLogout(statusCode: statusCode))
                }
            } else {
                useCase.createExpense(expense: expense) { [weak self] error, statusCode in
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

//
//  CreateOrEditExpenseViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

class CreateOrEditExpenseViewModel: ObservableObject {
    private let useCase: ExpenseUseCase = ExpenseUseCaseImpl()
    @Published var title: FieldModel = .init(value: "", fieldType: .name)
    @Published var description: FieldModel = .init(value: "", fieldType: .description)
    @Published var amount: FieldModel = .init(value: "", fieldType: .amount)
    @Published var shouldShowLoader: Bool?
    @Published var isEdit: Bool = false
    @Published var error: Error?
    var buttonTitle: String = ""
    var pageTitle: String = ""
    private var expense: Expense?

    init(expense: Expense?) {
        isEdit = expense != nil
        self.expense = expense
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

    func createOrUpdateExpense(completionHandler: @escaping () -> Void) {
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
                useCase.editExpense(expense: expense) { [weak self] error in
                    self?.shouldShowLoader = false
                    self?.error = error
                    completionHandler()
                }
            } else {
                useCase.createExpense(expense: expense) { [weak self] error in
                    self?.shouldShowLoader = false
                    self?.error = error
                    completionHandler()
                }
            }
        }
    }

    private func setupTitles() {
        buttonTitle = isEdit ? "Save" : "Update"
        pageTitle = isEdit ? "Edit Expense" : "Create Expense"
    }
}

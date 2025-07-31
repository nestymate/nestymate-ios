//
//  CreateOrEditExpenseViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

final class CreateOrEditExpenseViewModel: ObservableObject {
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
    @Published var error: HttpError?
    var buttonTitle: String = ""
    var pageTitle: String = ""
    private var expenseId: Int?

    init(
        expenseId: Int?,
        useCase: ExpenseUseCase,
        categoryUseCase: CategoryUseCase,
        logoutService: LogoutService
    ) {
        isEdit = expenseId != nil
        self.expenseId = expenseId
        self.useCase = useCase
        self.categoryUseCase = categoryUseCase
        self.logoutService = logoutService
        setupTitles()
    }

    var shouldEnableButton: Bool {
        !title.value.isEmpty && !description.value.isEmpty && !amount.value.isEmpty
    }

    func setup(expense: Expense?) {
        guard let expense else { return }
        title = .init(value: expense.title ?? "''", fieldType: .name)
        description = .init(value: expense.description, fieldType: .description)
        amount = .init(value: String(expense.amount), fieldType: .amount)
    }

    @MainActor
    public func getCategories() async throws -> (Int?, Bool) {
        shouldShowLoader = true
        do {
            let response = try await categoryUseCase.getCategories()
            categories = categories
            if isEdit, let expenseId {
                let response = try await useCase.getExpense(expenseId: expenseId)
                setup(expense: response.expense)
                return (response.expense?.categoryId, logoutService.shouldLogout(statusCode: response.statusCode))
            } else {
                if categories.count > 0 {
                    return (categories[0].id, logoutService.shouldLogout(statusCode: response.statusCode))
                } else {
                    return (nil, logoutService.shouldLogout(statusCode: response.statusCode))
                }
            }
        } catch {
            self.error = error as? HttpError
        }
        shouldShowLoader = false
        return (nil, false)
    }

    @MainActor
    func createOrUpdateExpense(expenseCategoryId: Int?) async throws -> Bool {
        let response = useCase.createValid(
            isTitleValid: title.onValidate(),
            isDescriptionValid: description.onValidate(),
            isAmountValid: amount.onValidate()
        )
        
        if response.success {
            shouldShowLoader = true
            let amountInDouble = Double(amount.value) ?? 0.0
            let expense = Expense(
                id: expenseId ?? 0,
                title: title.value,
                description: description.value,
                amount: amountInDouble,
                categoryId: expenseCategoryId
            )
            do {
                if isEdit {
                    let response = try await useCase.editExpense(expense: expense)
                    return logoutService.shouldLogout(statusCode: response.statusCode)
                } else {
                    let response = try await useCase.createExpense(expense: expense)
                    return logoutService.shouldLogout(statusCode: response.statusCode)
                }
            } catch {
                self.error = error as? HttpError
            }
        } else {
            error = response.error
        }
        shouldShowLoader = false
        return false
    }

    private func setupTitles() {
        buttonTitle = isEdit ? String(localized: "update") : String(localized: "save")
        pageTitle = isEdit ? String(localized: "edit_expense") : String(localized: "create_expense")
    }
}

//
//  CreateOrEditExpenseViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

final class CreateOrEditExpenseViewModel: ObservableObject {
    private let useCase: ExpenseUseCase
    private let homeUseCase: HomeUseCase
    private let categoryUseCase: CategoryUseCase
    private let logoutService: LogoutService
    var categoryTitle = String(localized: "category")
    var usersTitle = String(localized: "users")
    @Published var categories: [Category] = []
    @Published var users: [UserExpense] = []
    @Published var title: FieldModel = .init(value: "", fieldType: .name)
    @Published var date: FieldModel = .init(value: "", fieldType: .date)
    @Published var description: FieldModel = .init(value: "", fieldType: .description)
    @Published var amount: FieldModel = .init(value: "", fieldType: .amount)
    @Published var shouldShowLoader: Bool?
    @Published var isEdit: Bool = false
    @Published var error: HttpError?
    @Published var selectedCategory: Category?
    @Published var selectedUser: UserExpense?
    var buttonTitle: String = ""
    var pageTitle: String = ""
    private var expenseId: Int?
    private let formatter = DateFormatter()

    init(
        expenseId: Int?,
        useCase: ExpenseUseCase,
        homeUseCase: HomeUseCase,
        categoryUseCase: CategoryUseCase,
        logoutService: LogoutService
    ) {
        isEdit = expenseId != nil
        self.expenseId = expenseId
        self.useCase = useCase
        self.homeUseCase = homeUseCase
        self.categoryUseCase = categoryUseCase
        self.logoutService = logoutService
        setupTitles()
    }

    var shouldEnableButton: Bool {
        !title.value.isEmpty && !description.value.isEmpty && !amount.value.isEmpty
    }

    @MainActor
    func getExpense() async throws {
        shouldShowLoader = true
        do {
            let homeId = try await getHome()
            try await getCategories(homeId: homeId)
            try await getUsers(homeId: homeId)
            if isEdit, let expenseId {
                let response = try await useCase.getExpense(homeId: homeId, expenseId: expenseId)
                setup(expense: response.expense)
                shouldShowLoader = false
            } else {
                selectedCategory = categories.first
                selectedUser = users.first
            }
        } catch {
            self.error = error as? HttpError
        }
        shouldShowLoader = false
    }

    @MainActor
    private func getHome() async throws -> Int {
        let responseHome = try await homeUseCase.getActiveHome()
        return responseHome.home?.id ?? -1
    }

    @MainActor
    private func getCategories(homeId: Int) async throws {
        let response = try await categoryUseCase.getCategories(homeId: homeId)
        categories = response.categories ?? []
    }

    @MainActor
    private func getUsers(homeId: Int) async throws {
        let response = try await useCase.getUserForHome(homeId: homeId)
        users = response.users ?? []
    }

    @MainActor
    func createOrUpdateExpense() async throws -> Bool {
        formatter.dateFormat = DateUtils.backendFormat
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
                amount: amountInDouble,
                date: formatter.string(from: date.dateValue),
                description: description.value,
                expenseCategoryId: selectedCategory?.id,
                participatingUserIds: [selectedUser?.id ?? 0]
            )
            do {
                let responseHome = try await homeUseCase.getActiveHome()
                let homeId = responseHome.home?.id ?? -1
                if isEdit {
                    _ = try await useCase.editExpense(expense: expense)
                    shouldShowLoader = false
                } else {
                    _ = try await useCase.createExpense(
                        homeId: homeId,
                        expense: expense
                    )
                    shouldShowLoader = false
                }
                return true
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

    private func setup(expense: Expense?) {
        guard let expense else { return }

        title = .init(value: expense.title ?? "''", fieldType: .name)
        description = .init(value: expense.description ?? "", fieldType: .description)
        amount = .init(value: String(expense.amount), fieldType: .amount)
        date = .init(value: calculateDate(dateValue: expense.date), fieldType: .date)
        selectedCategory = expense.expenseCategory
    }

    private func calculateDate(dateValue: String?) -> String {
        formatter.dateFormat = DateUtils.expenseFormat
        guard let dateValue, let tempDate = formatter.date(from: dateValue) else { return DateUtils.getToday() }
        formatter.dateFormat = DateUtils.appFormat
        return formatter.string(from: tempDate)
    }
}

//
//  ExpensesTests.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 10/3/25.
//

@testable import nestymate_ios
import Testing

class ExpensesTests {
    private var useCase: ExpenseUseCase {
        ExpenseUseCaseImpl(service: ExpensesServiceMock())
    }

    private var useCaseFailed: ExpenseUseCase {
        ExpenseUseCaseImpl(service: ExpensesServiceFailedMock())
    }

    @Test func checkValid() {
        #expect(useCase.createValid(isTitleValid: true, isDescriptionValid: true, isAmountValid: true).0)
    }

    @Test func checkInValid() {
        #expect(useCase.createValid(
            isTitleValid: false,
            isDescriptionValid: true,
            isAmountValid: true
        ).1 == .fillAllValues)
    }

    @Test func successfulGetExpenses() {
        useCase.getExpenses { _, error, _ in
            #expect(error == nil)
        }
    }

    @Test func unsuccessfulGetExpenses() {
        useCaseFailed.getExpenses { _, error, _ in
            #expect(error != nil)
        }
    }

    @Test func successfulGetExpense() {
        useCase.getExpense(expenseId: 0) { _, error, _ in
            #expect(error == nil)
        }
    }

    @Test func unsuccessfulGetExpense() {
        useCaseFailed.getExpense(expenseId: 0) { _, error, _ in
            #expect(error != nil)
        }
    }

    @Test func successfulEditExpense() {
        useCase.editExpense(expense: ExpenseTestData.expense) { error, _ in
            #expect(error == nil)
        }
    }

    @Test func unSuccessfulEditExpense() {
        useCaseFailed.editExpense(expense: ExpenseTestData.expense) { error, _ in
            #expect(error != nil)
        }
    }

    @Test func successfulCreateExpensey() {
        useCase.createExpense(expense: ExpenseTestData.expense) { error, _ in
            #expect(error == nil)
        }
    }

    @Test func unSuccessfulCreateExpense() {
        useCaseFailed.createExpense(expense: ExpenseTestData.expense) { error, _ in
            #expect(error != nil)
        }
    }

    @Test func successfulDeleteExpense() {
        useCase.deleteExpense(expense: ExpenseTestData.expense) { error, _ in
            #expect(error == nil)
        }
    }

    @Test func unSuccessfulDeleteExpense() {
        useCaseFailed.deleteExpense(expense: ExpenseTestData.expense) { error, _ in
            #expect(error != nil)
        }
    }
}

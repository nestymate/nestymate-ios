//
//  ExpensesView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import SwiftUI

struct ExpensesView: View {
    @ObservedObject var viewModel: ExpensesViewModel
    @State private var expenses: [Expense] = []
    struct Output {
        var goToMyHome: () -> Void
        var goToCreateExpense: () -> Void
        var goToEditExpense: (Int?) -> Void
        var logout: () -> Void
    }

    var output: Output
    var body: some View {
        VStack {
            Button(action: {
                output.goToMyHome()
            }, label: {
                HStack {
                    Text(String(localized: "my_home")).font(FontManager.title)
                    Image(systemName: "slider.vertical.3")
                }
            })
            HStack {
                Spacer()
                Button {
                    output.goToCreateExpense()
                } label: {
                    Text(String(localized: "create"))
                }
            }
            .padding()
            List {
                ForEach(expenses, id: \.title) { item in
                    HStack {
                        Text(item.title ?? "")
                        Spacer()
                        Text(String(item.amount))
                    }
                    .padding()
                    .background(ColorManager.backgroundList)
                    .cornerRadius(12)
                    .onTapGesture {
                        output.goToEditExpense(item.id)
                    }
                }
                .onDelete(perform: { offset in
                    let index = offset[offset.startIndex]
                    Task {
                        let response = try await viewModel.delete(expenseToBeDelete: expenses[index])
                        handleExpenses(response.expenses, response.shouldLogout)
                    }
                })
                .listRowInsets(EdgeInsets())
                .padding(.vertical, 2)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
            .padding()
        }
        .background(ColorManager.backgroundColour)
        .onAppear {
            Task {
                let response = try await viewModel.getExpenses()
                handleExpenses(response.expenses, response.shouldLogout)
            }
        }
    }
}

private extension ExpensesView {
    func handleExpenses(_ expenses: [Expense]?, _ shouldLogout: Bool) {
        guard !shouldLogout else { return output.logout() }
        self.expenses = expenses ?? []
    }
}

#Preview {
    ExpensesView(viewModel: ExpensesViewModel(
        useCase: ExpenseUseCaseImpl(service: ExpensesServiceMock()),
        homeUseCase: HomeUseCaseImpl(homeService: HomeServiceImpl()),
        logoutService: LogoutService()
    ),
    output: ExpensesView.Output(
        goToMyHome: {},
        goToCreateExpense: {},
        goToEditExpense: { _ in },
        logout: {}
    ))
}

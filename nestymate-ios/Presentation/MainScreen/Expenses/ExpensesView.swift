//
//  ExpensesView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import SwiftUI

struct ExpensesView: View {
    @ObservedObject var viewModel: ExpensesViewModel
    @State private var viewDidLoad = false
    struct Output {
        var goToMyHome: () -> Void
        var goToCreateExpense: () -> Void
        var goToEditExpense: (Expense?) -> Void
        var logout: () -> Void
    }

    var output: Output
    var body: some View {
        VStack {
            Button(action: {
                self.output.goToMyHome()
            }, label: {
                HStack {
                    Text(String(localized: "my_home")).font(FontManager.title)
                    Image(systemName: "slider.vertical.3")
                }
            })
            HStack {
                Spacer()
                Button {
                    self.output.goToCreateExpense()
                } label: {
                    Text(String(localized: "create"))
                }
            }
            .padding()
            List {
                ForEach(viewModel.expenses, id: \.title) { item in
                    HStack {
                        Text(item.title ?? "")
                        Spacer()
                        Text(String(item.amount))
                    }
                    .onTapGesture {
                        self.output.goToEditExpense(item)
                    }
                }
                .onDelete(perform: { index in
                    viewModel.delete(at: index) { shouldLogout in
                        guard !shouldLogout else { return self.output.logout() }
                    }
                })
                .listRowBackground(ColorManager.backgroundColour)
            }
            .scrollContentBackground(.hidden)
            .padding()
        }
        .background(ColorManager.backgroundColour)
        .onAppear {
            viewModel.getExpenses { shouldLogout in
                guard !shouldLogout else { return self.output.logout() }
            }
        }
    }
}

#Preview {
    ExpensesView(viewModel: ExpensesViewModel(
        useCase: ExpenseUseCaseImpl(service: ExpenseServiceImpl()),
        logoutService: LogoutService()
    ),
    output: ExpensesView.Output(
        goToMyHome: {},
        goToCreateExpense: {},
        goToEditExpense: { _ in },
        logout: {}
    ))
}

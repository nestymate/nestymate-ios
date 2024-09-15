//
//  ExpensesView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import SwiftUI

struct ExpensesView: View {
    @ObservedObject var viewModel: ExpensesViewModel = .init()
    @State private var expenses: [Expense] = []
    @State private var viewDidLoad = false
    struct Output {
        var goToMyHome: () -> Void
        var goToCreateExpense: () -> Void
        var goToEditExpense: (Expense?) -> Void
    }

    var output: Output
    var body: some View {
        VStack {
            Button(action: {
                self.output.goToMyHome()
            }, label: {
                Text("My Home").font(FontManager.title)
            })
            HStack {
                Spacer()
                Button {
                    self.output.goToCreateExpense()
                } label: {
                    Text("Create")
                }
            }
            .padding()
            List {
                ForEach(expenses, id: \.title) { item in
                    HStack {
                        Text(item.title ?? "")
                        Spacer()
                        Text(String(item.amount))
                    }.onTapGesture {
                        self.output.goToEditExpense(item)
                    }
                }
                .onDelete(perform: viewModel.delete)
            }
            .padding()
        }
        .onAppear {
            viewModel.getExpenses { expenses in
                guard let expenses else { return self.expenses = [] }
                self.expenses = expenses
            }
        }
    }
}

#Preview {
    ExpensesView(output: ExpensesView.Output(
        goToMyHome: {},
        goToCreateExpense: {},
        goToEditExpense: { _ in }
    )
    )
}

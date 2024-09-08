//
//  ExpensesView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import SwiftUI
struct ExpensesView: View {
    @ObservedObject var viewModel: ExpensesViewModel = .init()
    struct Output {
        var goToMyHome: () -> Void
    }
    var output: Output
    var body: some View {
        VStack {
            Button(action: {
                self.output.goToMyHome()
            }, label: {
                Text("My Home")
            })
            List(viewModel.expenses) {
                Text($0.name)
            }
        }
    }
}

#Preview {
    ExpensesView(output: ExpensesView.Output.init(goToMyHome: {}))
}

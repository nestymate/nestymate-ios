//
//  ExpensesView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import SwiftUI

struct ExpensesView: View {
    var token = KeychainHelper().read() ?? "No token"
    var body: some View {
        Text(token)
    }
}

#Preview {
    ExpensesView()
}

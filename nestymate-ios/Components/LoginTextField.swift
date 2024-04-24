//
//  LoginTextField.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 24/4/24.
//

import SwiftUI

struct LoginTextField: View {
    var title: String
    var value: Binding<String>

    var body: some View {
        VStack {
            TextField(
                "",
                text: value,
                prompt: Text(title).foregroundColor(.gray)
            )
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            Divider()
                .frame(height: 1)
                .background(ColorManager.seperatorColour)
        }
        .padding(PaddingManager.normalPadding)
    }
}

#Preview {
    LoginTextField(title: "username", value: .constant(""))
}

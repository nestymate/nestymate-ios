//
//  PasswordTextField.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 11/7/24.
//

import SwiftUI

struct PasswordTextField: View {
    static let eyeIcon: String = "eye"
    static let eyeSlashIcon: String = eyeIcon + ".slash"
    var fieldModel: Binding<FieldModel>
    @State var isSecure: Bool = true

    var body: some View {
        ZStack(alignment: .trailing) {
            VStack {
                if isSecure {
                    VStack {
                        SecureField(
                            "",
                            text: fieldModel.value,
                            prompt: Text(fieldModel.fieldType.wrappedValue.placeHolder)
                                .foregroundColor(ColorManager.separatorColour)
                        )
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        Divider()
                            .frame(height: 1)
                            .background(ColorManager.separatorColour)
                    }
                    .padding(PaddingManager.normalPadding)

                } else {
                    VStack {
                        TextField(
                            "",
                            text: fieldModel.value,
                            prompt: Text(fieldModel.fieldType.wrappedValue.placeHolder).foregroundColor(.gray)
                        )
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        Divider()
                            .frame(height: 1)
                            .background(ColorManager.separatorColour)
                    }
                    .padding(PaddingManager.normalPadding)
                }

                if let error = fieldModel.error.wrappedValue {
                    HStack {
                        Text(error)
                            .font(FontManager.footnote)
                            .foregroundStyle(ColorManager.errorColor)
                            .multilineTextAlignment(.leading)

                        Spacer()
                    }
                    .padding(.leading, PaddingManager.normalPadding)
                }
            }

            Button(action: {
                isSecure = !isSecure
            }, label: {
                Image(systemName: !isSecure ? PasswordTextField.eyeIcon : PasswordTextField.eyeSlashIcon)
                    .foregroundColor(.gray)
                    .padding()
            })
        }
        .animation(.easeInOut(duration: 0.3), value: isSecure)
    }
}

#Preview {
    PasswordTextField(fieldModel: .constant(FieldModel(value: "", fieldType: .password)))
}

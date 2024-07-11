//
//  SingleTextField.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 24/4/24.
//

import SwiftUI

struct SingleTextField: View {
    var fieldModel: Binding<FieldModel>

    var body: some View {
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
                .background(ColorManager.seperatorColour)

            if let error = fieldModel.error.wrappedValue {
                HStack {
                    Text(error)
                        .font(FontManager.footnote)
                        .foregroundStyle(ColorManager.errorColor)
                        .multilineTextAlignment(.leading)

                    Spacer()
                }
            }
        }
        .padding(PaddingManager.normalPadding)
    }
}

#Preview {
    SingleTextField(fieldModel: .constant(FieldModel(value: "", fieldType: .email)))
}

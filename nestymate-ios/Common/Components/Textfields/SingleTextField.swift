//
//  SingleTextField.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 24/4/24.
//

import SwiftUI

struct SingleTextField: View {
    private var fieldModel: Binding<FieldModel>
    @FocusState private var isInputActive: FieldType?

    private var keyboardType: UIKeyboardType {
        switch fieldModel.fieldType.wrappedValue {
        case .amount:
            .numberPad
        case .email:
            .emailAddress
        default:
            .default
        }
    }

    public init(fieldModel: Binding<FieldModel>) {
        self.fieldModel = fieldModel
    }

    var body: some View {
        VStack {
            TextField(
                "",
                text: fieldModel.value,
                prompt: Text(fieldModel.fieldType.wrappedValue.placeHolder)
                    .foregroundColor(ColorManager.separatorColour)
            )
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .focused($isInputActive, equals: fieldModel.fieldType.wrappedValue)
            .keyboardType(keyboardType)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    if $isInputActive.wrappedValue == .amount {
                        Spacer()

                        Button("Done") {
                            isInputActive = nil
                        }
                    } else {
                        EmptyView()
                    }
                }
            }
            Divider()
                .frame(height: 1)
                .background(ColorManager.separatorColour)

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
    SingleTextField(fieldModel: .constant(FieldModel(value: "", fieldType: .name)))
}

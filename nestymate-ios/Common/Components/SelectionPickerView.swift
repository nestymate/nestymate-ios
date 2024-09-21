//
//  SelectionPickerView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/7/24.
//

import SwiftUI

struct SelectionPickerView: View {
    @State var options: [String]
    var fieldModel: Binding<FieldModel>
    var body: some View {
        HStack {
            Text(String(localized: "please_select"))
            Picker(String(localized: "please_choose"), selection: fieldModel.value) {
                ForEach(options, id: \.self) {
                    Text($0)
                }
            }
            .accentColor(ColorManager.mainColor)
            Spacer()
        }
        .padding(PaddingManager.normalPadding)
    }
}

#Preview {
    SelectionPickerView(options: ["male", "female", "other"], fieldModel: .constant(
        FieldModel(value: "", fieldType: .gender)))
}

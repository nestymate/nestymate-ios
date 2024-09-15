//
//  DatePickerUIView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 21/7/24.
//

import SwiftUI

struct DatePickerUIView: View {
    @State var title: String
    var fieldModel: Binding<FieldModel>
    var body: some View {
        DatePicker(selection: fieldModel.dateValue, in: ...Date.now, displayedComponents: .date) {
            Text(title)
        }
        .padding(PaddingManager.normalPadding)
    }
}

#Preview {
    DatePickerUIView(title: "", fieldModel: .constant(FieldModel(value: "", fieldType: .birthday)))
}

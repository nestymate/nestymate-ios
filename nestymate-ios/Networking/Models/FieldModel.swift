//
//  FieldModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 12/7/24.
//

import Foundation

struct FieldModel: Equatable {
    var value: String
    var dateValue: Date
    var error: String?
    var fieldType: FieldType

    init(value: String, dateValue: Date = .now, fieldType: FieldType, error: String? = nil) {
        self.value = value
        self.dateValue = dateValue
        self.fieldType = fieldType
        self.error = error
    }

    mutating func onValidate() -> Bool {
        error = fieldType.validate(value: value)
        return error == nil
    }
}

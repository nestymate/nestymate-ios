//
//  FieldModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 12/7/24.
//

import Foundation

struct FieldModel {
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

    mutating func onSubmitError() -> Bool {
        let isValid = fieldType.validate(value: value)
        return error == isValid
    }
}

// For date
extension FieldModel {
    mutating func onValidateDate() -> Bool {
        error = fieldType.validate(value: dateValue)
        return error == nil
    }

    mutating func onSubmitDateError() -> Bool {
        let isValid = fieldType.validate(value: value)
        return error == isValid
    }
}

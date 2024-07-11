//
//  FieldModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 12/7/24.
//

import Foundation

struct FieldModel {
    var value: String
    var error: String?
    var fieldType: FieldType

    init(value: String, fieldType: FieldType, error: String? = nil) {
        self.value = value
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

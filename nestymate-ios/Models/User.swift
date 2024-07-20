//
//  User.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/7/24.
//

import Foundation

struct User: Encodable, Decodable {
    let username: String
    let password: String
    let repeatPassword: String
    let name: String
    let surname: String
    let birthday: String
    let gender: String

    var isValid: Bool {
        !username.isEmpty
            && isPasswordValid
            && !name.isEmpty
            && !surname.isEmpty
            && !birthday.isEmpty
            && !gender.isEmpty
    }

    var isPasswordValid: Bool {
        // least one uppercase,
        // least one digit
        // least one lowercase
        // least one symbol
        //  min 8 characters total
        let password = password.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegx)
        return passwordCheck.evaluate(with: password)
    }

    var isPasswordsTheSame: Bool {
        password == repeatPassword
    }
}

//
//  SignUpTestsData.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 27/12/24.
//

@testable import nestymate_ios

enum SignUpTestsData {
    static let emptyValuesUser = User(
        username: "",
        password: "",
        repeatPassword: "",
        name: "",
        surname: "",
        birthday: "",
        gender: ""
    )

    static let emptyNameUser = User(
        username: "",
        password: "Sadface123!",
        repeatPassword: "Sadface123!",
        name: "Seli", surname: "Kyriaz",
        birthday: "1992-12-27",
        gender: "other"
    )

    static let correctUser = User(
        username: "Selini",
        password: "Sadface123!",
        repeatPassword: "Sadface123!",
        name: "Seli", surname: "Kyriaz",
        birthday: "1992-12-27",
        gender: "other"
    )

    static let incorrectPasswordUser = User(
        username: "Selini",
        password: "123",
        repeatPassword: "123",
        name: "Seli", surname: "Kyriaz",
        birthday: "1992-12-27",
        gender: "other"
    )

    static let notMatchingPasswordUser = User(
        username: "Selini",
        password: "Sadface123!",
        repeatPassword: "Sadface123!!",
        name: "Seli", surname: "Kyriaz",
        birthday: "1992-12-27",
        gender: "other"
    )

    static let incorrectBirthdayUser = User(
        username: "Selini",
        password: "Sadface123!",
        repeatPassword: "Sadface123!",
        name: "Seli", surname: "Kyriaz",
        birthday: DateUtils.getToday(),
        gender: "other"
    )
}

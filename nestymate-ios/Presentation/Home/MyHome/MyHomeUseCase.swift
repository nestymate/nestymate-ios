//
//  MyHomeUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 14/9/24.
//

import Foundation

protocol MyHomeUseCase {
    func inviteUserToHome(email: String, completionHandler: @escaping (Error?) -> Void)
    func getHome(completionHandler: @escaping (Home?, Error?) -> Void)
    func editHome(home: Home, completionHandler: @escaping (Error?) -> Void)
    func createValid(isNameValid: Bool, isDescriptionValid: Bool, isAddressValid: Bool) -> Bool
}

class MyHomeUseCaseImpl: MyHomeUseCase {
    let homeService: HomeService

    init(homeService: HomeService) {
        self.homeService = homeService
    }

    func createValid(isNameValid: Bool, isDescriptionValid: Bool, isAddressValid: Bool) -> Bool {
        return isNameValid && isDescriptionValid && isAddressValid
    }

    func getHome(completionHandler: @escaping (Home?, Error?) -> Void) {
        homeService.getHome(completionHandler: completionHandler)
    }

    func editHome(home: Home, completionHandler: @escaping (Error?) -> Void) {
        homeService.editHome(home: home, completionHandler: completionHandler)
    }

    func inviteUserToHome(email: String, completionHandler: @escaping (Error?) -> Void) {
        homeService.inviteUserToHome(email: email, completionHandler: completionHandler)
    }
}

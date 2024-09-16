//
//  HomeUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 14/9/24.
//

import Foundation

protocol HomeUseCase {
    func inviteUserToHome(email: String, completionHandler: @escaping (Error?, Int?) -> Void)
    func getHome(completionHandler: @escaping (Home?, Error?, Int?) -> Void)
    func editHome(home: Home, completionHandler: @escaping (Error?, Int?) -> Void)
    func createValid(isNameValid: Bool, isDescriptionValid: Bool, isAddressValid: Bool) -> Bool
    func createHome(home: Home, completionHandler: @escaping (Error?, Int?) -> Void)
}

class HomeUseCaseImpl: HomeUseCase {
    let homeService: HomeService

    init(homeService: HomeService) {
        self.homeService = homeService
    }

    func createValid(isNameValid: Bool, isDescriptionValid: Bool, isAddressValid: Bool) -> Bool {
        return isNameValid && isDescriptionValid && isAddressValid
    }

    func getHome(completionHandler: @escaping (Home?, Error?, Int?) -> Void) {
        homeService.getHome(completionHandler: completionHandler)
    }

    func editHome(home: Home, completionHandler: @escaping (Error?, Int?) -> Void) {
        homeService.editHome(home: home, completionHandler: completionHandler)
    }

    func inviteUserToHome(email: String, completionHandler: @escaping (Error?, Int?) -> Void) {
        homeService.inviteUserToHome(email: email, completionHandler: completionHandler)
    }

    func createHome(home: Home, completionHandler: @escaping (Error?, Int?) -> Void) {
        homeService.createHome(home: home, completionHandler: completionHandler)
    }
}

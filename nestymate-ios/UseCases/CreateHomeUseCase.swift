//
//  CreateHomeUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//
import Foundation

protocol CreateHomeUseCase {
    func createValid(isNameValid: Bool, isDescriptionValid: Bool, isAddressValid: Bool) -> Bool
    func createHome(name: String, description: String, address: String, completionHandler: @escaping (Error?) -> Void)
}

class CreateHomeUseCaseImpl: CreateHomeUseCase {
    let service: HomeService

    init(service: HomeService) {
        self.service = service
    }

    func createValid(isNameValid: Bool, isDescriptionValid: Bool, isAddressValid: Bool) -> Bool {
        return isNameValid && isDescriptionValid && isAddressValid
    }

    func createHome(name: String, description: String, address: String, completionHandler: @escaping (Error?) -> Void) {
        service.createHome(name: name, description: description, address: address, completionHandler: completionHandler)
    }
}

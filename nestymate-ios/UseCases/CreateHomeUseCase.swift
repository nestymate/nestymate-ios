//
//  CreateHomeUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//
import Foundation

protocol CreateHomeUseCase {
    func createHome(name: String, description: String, address: String, completionHandler: @escaping () -> Void)
}

class CreateHomeUseCaseImpl: CreateHomeUseCase {
    let service: HomeService = HomeServiceImpl()
    func createHome(name: String, description: String, address: String, completionHandler: @escaping () -> Void) {
        service.createHome(name: name, description: description, address: address, completionHandler: completionHandler)
    }
}

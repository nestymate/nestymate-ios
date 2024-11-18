//
//  CreateOrEditHomeViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//

import Foundation
import SwiftUI

class CreateOrEditHomeViewModel: ObservableObject {
    private let useCase: HomeUseCase
    private let logoutService = LogoutService()
    @Published public var name: FieldModel = .init(value: "", fieldType: .name)
    @Published public var description: FieldModel = .init(value: "", fieldType: .description)
    @Published public var address: FieldModel = .init(value: "", fieldType: .address)
    @Published public var shouldShowLoader: Bool?
    @Published var isEdit: Bool = false
    @Published var error: Error?
    var buttonTitle: String = ""
    var pageTitle: String = ""
    var shouldEnableButton: Bool {
        !name.value.isEmpty && !description.value.isEmpty && !address.value.isEmpty
    }

    private var home: Home?

    init(useCase: HomeUseCase, isEdit: Bool) {
        self.useCase = useCase
        self.isEdit = isEdit
        setupTitles()
    }

    public func getHome() {
        shouldShowLoader = true
        useCase.getHome { [weak self] home, error, _ in
            guard let self else { return }
            shouldShowLoader = false
            self.error = error
            guard let home else { return }
            self.home = home
            name = .init(value: home.name, fieldType: .name)
            description = .init(value: home.description, fieldType: .description)
            address = .init(value: home.address, fieldType: .address)
        }
    }

    public func createOrEditHome(completionHandler: @escaping (Bool) -> Void) {
        if isEdit {
            editHome(completionHandler)
        } else {
            createHome(completionHandler)
        }
    }

    private func createHome(_ completionHandler: @escaping (Bool) -> Void) {
        if useCase.createValid(
            isNameValid: name.onValidate(),
            isDescriptionValid: description.onValidate(),
            isAddressValid: address.onValidate()
        ) {
            shouldShowLoader = true
            let home = Home(id: 0, name: name.value, description: description.value, address: address.value)
            useCase.createHome(home: home) { [weak self] error, statusCode in
                self?.shouldShowLoader = false
                self?.error = error
                completionHandler(self?.logoutService.shouldLogout(statusCode: statusCode) ?? false)
            }
        }
    }

    private func editHome(_ completionHandler: @escaping (Bool) -> Void) {
        if useCase.createValid(
            isNameValid: name.onValidate(),
            isDescriptionValid: description.onValidate(),
            isAddressValid: address.onValidate()
        ) {
            shouldShowLoader = true
            guard let originalHome = home else { return }
            let home = Home(
                id: originalHome.id,
                name: name.value,
                description: description.value,
                address: address.value
            )
            useCase.editHome(home: home) { [weak self] error, statusCode in
                self?.shouldShowLoader = false
                self?.error = error
                completionHandler(self?.logoutService.shouldLogout(statusCode: statusCode) ?? false)
            }
        }
    }

    private func setupTitles() {
        buttonTitle = isEdit ? String(localized: "update") : String(localized: "save")
        pageTitle = isEdit ? String(localized: "edit_home") : String(localized: "create_home")
    }
}

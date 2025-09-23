//
//  CreateOrEditHomeViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//

import Foundation
import SwiftUI

final class CreateOrEditHomeViewModel: ObservableObject {
    private let useCase: HomeUseCase
    private let logoutService = LogoutService()
    @Published public var name: FieldModel = .init(value: "", fieldType: .name)
    @Published public var description: FieldModel = .init(value: "", fieldType: .description)
    @Published public var address: FieldModel = .init(value: "", fieldType: .address)
    @Published public var active: Bool = false
    @Published public var shouldShowLoader: Bool?
    @Published var isEdit: Bool = false
    @Published var error: HttpError?
    var buttonTitle: String = ""
    var pageTitle: String = ""
    var shouldEnableButton: Bool {
        !name.value.isEmpty && !description.value.isEmpty && !address.value.isEmpty
    }

    private let homeId: Int?
    private var home: Home?

    init(useCase: HomeUseCase, homeId: Int?) {
        self.useCase = useCase
        isEdit = homeId != nil
        self.homeId = homeId
        setupTitles()
    }

    @MainActor
    public func getHome() async {
        guard let homeId else { return }
        shouldShowLoader = true
        do {
            let response = try await useCase.getHome(homeId: homeId)
            shouldShowLoader = false
            if let home = response.home {
                self.home = home
                name = .init(value: home.name, fieldType: .name)
                description = .init(value: home.description ?? "", fieldType: .description)
                address = .init(value: home.address ?? "", fieldType: .address)
                active = home.active
            }
        } catch {
            self.error = error as? HttpError
        }
    }

    @MainActor
    public func createOrEditHome() async throws -> Bool {
        if isEdit {
            try await editHome()
        } else {
            try await createHome()
        }
    }

    @MainActor
    private func createHome() async throws -> Bool {
        if useCase.createValid(
            isNameValid: name.onValidate(),
            isDescriptionValid: description.onValidate(),
            isAddressValid: address.onValidate()
        ) {
            shouldShowLoader = true
            let home = Home(
                id: 0,
                name: name.value,
                active: true,
                description: description.value,
                address: address.value
            )
            do {
                _ = try await useCase.createHome(home: home)
                shouldShowLoader = false
                return true
            } catch {
                self.error = error as? HttpError
            }
        }
        shouldShowLoader = false
        return false
    }

    @MainActor
    private func editHome() async throws -> Bool {
        if useCase.createValid(
            isNameValid: name.onValidate(),
            isDescriptionValid: description.onValidate(),
            isAddressValid: address.onValidate()
        ) {
            shouldShowLoader = true
            guard let originalHome = home else { return false }
            let home = Home(
                id: originalHome.id,
                name: name.value,
                active: active,
                description: description.value,
                address: address.value
            )
            do {
                _ = try await useCase.editHome(home: home)
                shouldShowLoader = false
                return true
            } catch {
                self.error = error as? HttpError
            }
        }
        shouldShowLoader = false
        return false
    }

    private func setupTitles() {
        buttonTitle = isEdit ? String(localized: "update") : String(localized: "save")
        pageTitle = isEdit ? String(localized: "edit_home") : String(localized: "create_home")
    }
}

//
//  NestymateTests.swift
//  NestymateTests
//
//  Created by Selini Kyriazidou on 18/4/24.
//

import Testing

@testable import nestymate_ios

@MainActor @Test func returnHomeAfterLogin() {
    let viewModel = LoginViewModel(
        useCase: LoginUseCaseImpl(
            service: LoginServiceMock(),
            homeService: HomeServiceMock()
        )
    )
    viewModel.login { home in
        #expect(home != nil)
    }
}

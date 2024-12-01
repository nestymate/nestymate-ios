//
//  LoginTests.swift
//  NestymateTests
//
//  Created by Selini Kyriazidou on 18/4/24.
//

import Testing

@testable import nestymate_ios

var viewModel: LoginViewModel {
    LoginViewModel(
        useCase: LoginUseCaseImpl(
            service: LoginServiceMock(),
            homeService: HomeServiceMock(hasHome: true)
        )
    )
}

var viewModelNotHome: LoginViewModel {
    LoginViewModel(
        useCase: LoginUseCaseImpl(
            service: LoginServiceMock(),
            homeService: HomeServiceMock(hasHome: false)
        )
    )
}

var viewModelFailed: LoginViewModel {
    LoginViewModel(
        useCase: LoginUseCaseImpl(
            service: LoginServiceFailedMock(),
            homeService: HomeServiceFailedMock()
        )
    )
}

@MainActor @Test func successfullLoginHasHome() {
    viewModel.login { home in
        #expect(home != nil)
    }
}

@MainActor @Test func successfullLoginHasNotHaveHome() {
    viewModelNotHome.login { home in
        #expect(home == nil)
    }
}

@MainActor @Test func unsuccessfullLogin() {
    viewModelFailed.login { home in
        #expect(home == nil)
    }
}

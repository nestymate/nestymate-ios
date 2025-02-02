//
//  ProfileTests.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 2/2/25.
//

@testable import nestymate_ios
import Testing

class ProfileTests {
    private var useCase: ProfileUseCase {
        ProfileUseCaseImpl()
    }

    @Test func logout() {
        useCase.logout {
            #expect(true)
        }
    }
}

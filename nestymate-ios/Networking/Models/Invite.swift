//
//  Invite.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 11/9/25.
//

public struct Invite: Encodable {
    public let inviteCode: String
}

public struct UserInvite: Encodable {
    public let email: String
}

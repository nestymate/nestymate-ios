//
//  KeychainHelper.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//

import Foundation
import Security

final class KeychainHelper {
    let service = "com.nestymate.LoginService"
    let account = "nestymate"
    static let standard = KeychainHelper()

    func save(_ data: Data) {
        // Create query
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
        ] as CFDictionary

        delete()

        // Add data in query to keychain
        let status = SecItemAdd(query, nil)

        if status != errSecSuccess {
            // Print out the error
            print("Error: \(status)")
        }
    }

    func read() -> String? {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true,
        ] as CFDictionary

        var result: AnyObject?
        SecItemCopyMatching(query, &result)

        guard let res = result as? Data, let str = String(data: res, encoding: .utf8) else { return nil }
        return str
    }

    func delete() {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary

        // Delete item from keychain
        SecItemDelete(query)
    }
}

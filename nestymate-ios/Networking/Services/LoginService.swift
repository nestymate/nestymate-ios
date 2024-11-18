//
//  LoginService.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import Combine
import Foundation

protocol LoginService {
    func login(username: String, password: String, completionHandler: @escaping (Error?) -> Void)
    func signup(user: User, completionHandler: @escaping (Error?) -> Void)
}

class LoginServiceImpl: LoginService {
    let mainUrl = URL(string: "http://192.168.1.10/auth")!
    var apiCall = APICalls()
    func login(username: String, password: String, completionHandler: @escaping (Error?) -> Void) {
        let url: URL = mainUrl.appending(path: "login")
        let data = try? JSONEncoder().encode(Login(username: username, password: password)) // "test123" "test321"
        apiCall.post(url: url, requestData: data, authentication: false) { apiResponse in
            if apiResponse.statusCode == 200 {
                guard let data = apiResponse.data,
                      let response = try? JSONDecoder().decode(Response.self, from: data)
                else {
                    return completionHandler(.badServerResponse)
                }

                print("We received token -------", response.token)
                let helper = KeychainHelper()
                helper.save(Data(response.token.utf8))
                completionHandler(apiResponse.error)

            } else if apiResponse.statusCode == 401 {
                return completionHandler(.passwordAndUserNameDidNotMatch)
            } else {
                return completionHandler(.badServerResponse)
            }
        }
    }

    func signup(user: User, completionHandler: @escaping (Error?) -> Void) {
        let url: URL = mainUrl.appending(path: "signup")
        let data = try? JSONEncoder().encode(user)
        apiCall.post(url: url, requestData: data, authentication: false) { apiResponse in
            guard let data = apiResponse.data,
                  let response = try? JSONDecoder().decode(Response.self, from: data)
            else {
                return completionHandler(.badServerResponse)
            }
            print(response.token)
            let helper = KeychainHelper()
            helper.save(Data(response.token.utf8))
            completionHandler(apiResponse.error)
        }
    }
}

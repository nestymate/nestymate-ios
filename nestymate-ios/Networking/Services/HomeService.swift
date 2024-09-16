//
//  HomeService.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//

import Combine
import Foundation

protocol HomeService {
    func inviteUserToHome(email: String, completionHandler: @escaping (Error?, Int?) -> Void)
    func createHome(home: Home, completionHandler: @escaping (Error?, Int?) -> Void)
    func editHome(home: Home, completionHandler: @escaping (Error?, Int?) -> Void)
    func getHome(completionHandler: @escaping (Home?, Error?, Int?) -> Void)
}

class HomeServiceImpl: HomeService {
    let url = URL(string: "http://192.168.1.10/api/v1/home")!
    var cancellable = Set<AnyCancellable>()
    let helper = KeychainHelper()
    var apiCall = APICalls()

    func getHome(completionHandler: @escaping (Home?, Error?, Int?) -> Void) {
        apiCall.get(url: url, requestData: nil) { apiResponse in
            guard let data = apiResponse.data,
                  let response = try? JSONDecoder().decode(Home.self, from: data)
            else {
                if apiResponse.statusCode == 400 {
                    return completionHandler(nil, nil, apiResponse.statusCode)
                } else {
                    return completionHandler(nil, .badServerResponse, apiResponse.statusCode)
                }
            }
            return completionHandler(response, apiResponse.error, apiResponse.statusCode)
        }
    }

    func createHome(home: Home, completionHandler: @escaping (Error?, Int?) -> Void) {
        let data = try? JSONEncoder().encode(home)
        apiCall.post(url: url, requestData: data) { apiResponse in
            completionHandler(apiResponse.error, apiResponse.statusCode)
        }
    }

    func editHome(home: Home, completionHandler: @escaping (Error?, Int?) -> Void) {
        let data = try? JSONEncoder().encode(home)
        let putURL = url.appending(path: home.reference)
        apiCall.put(url: putURL, requestData: data) { apiResponse in
            completionHandler(apiResponse.error, apiResponse.statusCode)
        }
    }

    func inviteUserToHome(email: String, completionHandler: @escaping (Error?, Int?) -> Void) {
        let data = try? JSONEncoder().encode(email)
        apiCall.post(url: url, requestData: data) { apiResponse in
            completionHandler(apiResponse.error, apiResponse.statusCode)
        }
    }
}

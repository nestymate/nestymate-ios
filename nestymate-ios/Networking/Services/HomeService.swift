//
//  HomeService.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//

import Combine
import Foundation

protocol HomeService {
    func createHome(home: Home, completionHandler: @escaping (Error?) -> Void)
    func editHome(home: Home, completionHandler: @escaping (Error?) -> Void)
    func getHome(completionHandler: @escaping (Home?, Error?) -> Void)
}

class HomeServiceImpl: HomeService {
    let url = URL(string: "http://192.168.1.10/api/v1/home")!
    var cancellable = Set<AnyCancellable>()
    let helper = KeychainHelper()
    var apiCall = APICalls()

    func getHome(completionHandler: @escaping (Home?, Error?) -> Void) {
        apiCall.get(url: url, requestData: nil) { apiResponse in
            guard let data = apiResponse.data,
                  let response = try? JSONDecoder().decode(Home.self, from: data)
            else {
                if apiResponse.statusCode == 400 {
                    return completionHandler(nil, nil)
                } else {
                    return completionHandler(nil, .badServerResponse)
                }
            }
            return completionHandler(response, apiResponse.error)
        }
    }

    func createHome(home: Home, completionHandler: @escaping (Error?) -> Void) {
        let data = try? JSONEncoder().encode(home)
        apiCall.post(url: url, requestData: data) { apiResponse in
            completionHandler(apiResponse.error)
        }
    }

    func editHome(home: Home, completionHandler: @escaping (Error?) -> Void) {
        let data = try? JSONEncoder().encode(home)
        let putURL = url.appending(path: home.reference)
        apiCall.put(url: putURL, requestData: data) { apiResponse in
            completionHandler(apiResponse.error)
        }
    }
}

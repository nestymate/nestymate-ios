//
//  HomeService.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//

import Combine
import Foundation

protocol HomeService {
    func createHome(name: String, description: String, address: String, completionHandler: @escaping (Error?) -> Void)
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
                return completionHandler(nil, .badServerResponse)
            }
            if apiResponse.statusCode == 400 {
                completionHandler(nil, nil)
            } else {
                completionHandler(response, apiResponse.error)
            }
        }
    }

    func createHome(
        name: String,
        description: String,
        address: String,
        completionHandler: @escaping (Error?) -> Void
    ) {
        let data = try? JSONEncoder().encode(Home(name: name, description: description, address: address))
        apiCall.post(url: url, requestData: data) { apiResponse in
            completionHandler(apiResponse.error)
        }
    }
}

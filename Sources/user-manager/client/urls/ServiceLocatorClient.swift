//
//  ServiceLocatorClient.swift
//  user-manager
//
//  Created by Yuvraj Singh on 29/06/25.
//

import Foundation
import rest_client_api
import util

public class ServiceLocatorClient {
    private let locatorUrl: String
    private let env: Env
    private let restClient: RestClientAsync = UrlSessionRestClientAsync()
    private let json: Json = DefaultJson()

    public init(locatorUrl: String, env: Env) {
        self.locatorUrl = locatorUrl
        self.env = env
    }

    public func get() async -> [String: String] {
        var url = Url(baseUrl: locatorUrl, pathParams: "endpoints")
        url.queryParam(key: "env", value: env.rawValue)
        let request = Request(url: url)

        do {
            let response = try await restClient.get(request: request)
            if response.statusCode == 200 {
                return try json.decode(response.payload, as: [String: String].self)
            } else {
                return [:]
            }
        } catch {
            return [:]
        }
    }
}

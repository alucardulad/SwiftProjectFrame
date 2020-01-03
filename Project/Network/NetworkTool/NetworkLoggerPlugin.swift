//
//  NetworkLoggerPlugin.swift
//  VeSync
//
//  Created by dave on 2019/11/4.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import Moya
import Foundation
import Result

public final class NetworkLoggerPlugin: PluginType {

    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            logNetworkSuccess(request: response.request, responseData: response.data)
        case .failure(let error):
            logNetworkFailure(target: target, error: error)
        }
    }
}

extension NetworkLoggerPlugin {

    func logNetworkSuccess(request: URLRequest?, responseData: Data) {
        guard let url = request?.url else { return }
        guard let httpBody = request?.httpBody else { return }
        let requestBody = httpBody.prettyPrintedJSONString ?? ""
        #if DEBUG
        let responseObject = responseData.prettyPrintedJSONString ?? ""
        #else
        let responseObject = String(data: responseData, encoding: String.Encoding.utf8)
        #endif
        VSLog("""
            [NetWork]
            ==============================url==============================
            \(url)
            ===================RequestBody======================
            \(requestBody)
            ===================responseObject===================
            \(responseObject)
            ===============================================================
            """)
    }

    func logNetworkFailure(target: TargetType, error: MoyaError) {
        let url = target.baseURL.absoluteString + target.path
        let requestBody = target.task
        VSLog("""
            [NetWork]
            ==============================url==============================
            \(url)
            ===================RequestBody=============
            \(requestBody)
            ===================Error===================
            \(error)
            ===============================================================
            """)
    }
}

fileprivate extension Data {
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: String.Encoding.utf8) else { return nil }

        return prettyPrintedString
    }
}

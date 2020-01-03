//
//  NetworkProvider.swift
//  VeSync
//
//  Created by Sheldon on 2019/8/19.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import Foundation
import Moya
import RxSwift

/// 超时时长
private var requestTimeOut: Double = 30
/// 结果回调
typealias SuccessBlock = (JSON) -> Void
typealias FailureBlock = (NetworkError) -> Void

// MARK: - 设置请求头
private let myEndpointClosure = { (target: TargetType) -> Endpoint in
    var url = target.baseURL.absoluteString + target.path
    let endPoint = Endpoint(url: url,
                            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
    return endPoint
}

// MARK: - 设置超时 & 请求参数打印
private let myRequestClosure = { (endpoint: Endpoint, closure: @escaping MoyaProvider.RequestResultClosure) -> Void in
    do {
        var request = try endpoint.urlRequest()
        // 设置超时时长
        request.timeoutInterval = requestTimeOut
        closure(.success(request))
    } catch {
        closure(.failure(MoyaError.underlying(error, nil)))
    }
}

// MARK: - 监听请求开始结束
private let myNetworkActivityPlugin = NetworkActivityPlugin { (changeType, _) in
    // targetType 是当前请求的基本信息
    switch(changeType) {
    case .began:
        VSLog("开始请求网络")
    case .ended:
        VSLog("结束")
    }
}

// MARK: - 监听所有网络活动日志
private let myNetworkLoggerPlugin = NetworkLoggerPlugin()

// MARK: - 请求提供者
class NetworkProvider {
    /// MoyaProvider请求类
    private static let provider = MoyaProvider<MultiTarget>(endpointClosure: myEndpointClosure, requestClosure: myRequestClosure, plugins: [myNetworkActivityPlugin, myNetworkLoggerPlugin])
    
    /// 网络请求
    ///
    /// - Parameters:
    ///   - target: 请求接口类型
    ///   - success: 成功请求回调
    ///   - failure: 失败请求回调
    static func request(_ target: MultiTarget, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        _ = request(target).subscribe(onSuccess: { (json) in
            success(json)
        }, onError: { (error) in
            if let error: NetworkError = error as? NetworkError {
                failure(error)
            }
        })
    }
    
    /// 网络请求
    ///
    /// - Parameter target: 请求接口类型
    /// - Returns: 返回JSON序列
    @discardableResult
    static func request(_ target: MultiTarget) -> Single<JSON> {
        return Single.create { single in
            let request = provider.rx.request(target)
                .filterSuccessfulStatusCodes()
                .mapJSON()
                .subscribe({ (singleEvent) in
                    switch singleEvent {
                    case let .success(response):
                        handleSuccessResponse(response: JSON(response), single: single)
                    case let .error(error):
                        handleFailResponse(error: error, single: single)
                    }
                })
            return Disposables.create {
                request.dispose()
            }
        }
    }
    
    /// 网络请求
    /// - Parameter target: 请求接口类型
    /// - Returns: 返回模型，解析的模型T必须遵从HandyJSON协议, 如果T为数组，数组内的要解析的模型也必须遵从HandyJSON
    @discardableResult
    static func request<T>(_ target: MultiTarget) -> Single<Response<T>> {
        return Single.create { single in
            let request = provider.rx.request(target)
                .filterSuccessfulStatusCodes()
                .mapJSON()
                .subscribe({ (singleEvent) in
                    switch singleEvent {
                    case let .success(response):
                        handleSuccessResponse(json: JSON(response), single: single)
                    case let .error(error):
                        handleFailResponse(error: error, single: single)
                    }
                })
            return Disposables.create {
                request.dispose()
            }
        }
    }
    
    /// bypass接口请求
    /// - Parameter target: 请求接口类型
    @discardableResult
    static func request<T: HandyJSON>(_ target: MultiTarget) -> Single<BypassResponse<T>> {
        return Single.create { single in
            let request = provider.rx.request(target)
                .filterSuccessfulStatusCodes()
                .mapJSON()
                .subscribe({ (singleEvent) in
                    switch singleEvent {
                    case let .success(response):
                        handleSuccessResponse(json: JSON(response), single: single)
                    case let .error(error):
                        handleFailResponse(error: error, single: single)
                    }
                })
            return Disposables.create {
                request.dispose()
            }
        }
    }
}

extension NetworkProvider {
    // MARK: - 处理成功响应
    /// 处理成功响应
    ///
    /// - Parameter response: 响应数据
    private static func handleSuccessResponse(response: JSON, single: (SingleEvent<JSON>) -> Void ) {
        if let code = response["code"].int {
            if code == 0 {
                single(.success(response))
            } else {
                // 错误处理
                let errorStr = NetworkError.newHanleErrorCode(code: code)
                let error = NetworkError.error(code: code, msg: errorStr)
                single(.error(error))
            }
            return
        }
        // 老7a业务服务器逻辑
    }
    
    fileprivate static func handleSuccessResponse<T>(json: JSON, single: (SingleEvent<Response<T>>) -> Void ) {
        guard let response = Response<T>.deserialize(from: json.dictionaryObject) else {
            single(.error(NetworkError.modelMapping))
            return
        }
        if response.code == 0 {
            single(.success(response))
        } else {
            // 错误处理
            let errorStr = NetworkError.newHanleErrorCode(code: response.code)
            let error = NetworkError.error(code: response.code, msg: errorStr)
            single(.error(error))
        }
    }
    
    fileprivate static func handleSuccessResponse<T: HandyJSON>(json: JSON, single: (SingleEvent<BypassResponse<T>>) -> Void ) {
        guard let response = BypassResponse<T>.deserialize(from: json.dictionaryObject) else {
            single(.error(NetworkError.modelMapping))
            return
        }
        if response.code != 0 {
            // 云错误处理
            let errorStr = NetworkError.newHanleErrorCode(code: response.code)
            let error = NetworkError.error(code: response.code, msg: errorStr)
            single(.error(error))
            return
        }
        guard let result = response.result else {
            single(.success(response))
            return
        }
        if result.code != 0 {
            // 获取bypass错误描述
            let errorStr = ""
            let error = NetworkError.error(code: result.code, msg: errorStr)
            single(.error(error))
            return
        }
        single(.success(response))
    }
    
    // MARK: - 处理失败响应
    /// 处理失败响应
    ///
    /// - Parameter response: 响应数据
    fileprivate static func handleFailResponse(error: Error, single: (SingleEvent<JSON>) -> Void ) {
        // 错误处理
        let errorStr = NetworkError.msgWithError(error: error)
        single(.error(NetworkError.error(code: nil, msg: errorStr)))
    }
    
    fileprivate static func handleFailResponse<T>(error: Error, single: (SingleEvent<Response<T>>) -> Void ) {
        // 错误处理
        let errorStr = NetworkError.msgWithError(error: error)
        single(.error(NetworkError.error(code: nil, msg: errorStr)))
    }
    
    fileprivate static func handleFailResponse<T: HandyJSON>(error: Error, single: (SingleEvent<BypassResponse<T>>) -> Void ) {
        // 错误处理
        let errorStr = NetworkError.msgWithError(error: error)
        single(.error(NetworkError.error(code: nil, msg: errorStr)))
    }
}

// MARK: - 单元测试与mock数据用
class NetWorkMockProvider<Target: TargetType> {
    
    private let provider = MoyaProvider<Target>(endpointClosure: myEndpointClosure,
                                                requestClosure: myRequestClosure,
                                                stubClosure: MoyaProvider.immediatelyStub,
                                                plugins: [myNetworkActivityPlugin, myNetworkLoggerPlugin])
    /// mock数据请求，单元测试
    /// - Parameter target: 请求接口类型
    func stubRequest<T>(_ target: Target) -> Single<Response<T>> {
        return Single.create { single in
            let request = self.provider.rx.request(target)
                .filterSuccessfulStatusCodes()
                .mapJSON()
                .subscribe({ (singleEvent) in
                    switch singleEvent {
                    case let .success(response):
                        NetworkProvider.handleSuccessResponse(json: JSON(response), single: single)
                    case let .error(error):
                        NetworkProvider.handleFailResponse(error: error, single: single)
                    }
                })
            return Disposables.create {
                request.dispose()
            }
        }
    }
}

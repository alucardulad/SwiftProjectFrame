//
//  AppDelegate+Rx.swift
//  VeSync
//
//  Created by dave on 2019/8/25.
//  Copyright © 2019年 Etekcity. All rights reserved.
//

import RxSwift

extension AppDelegate {
    /// rxswift的资源计数的log
    @objc
    func rxswiftResourcesTotalDebugLog() {
        #if DEBUG
        _ = Observable<Int>.interval(.seconds(10), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                print("Rx Resource Count: \(RxSwift.Resources.total)")
            })
        #endif
    }
}

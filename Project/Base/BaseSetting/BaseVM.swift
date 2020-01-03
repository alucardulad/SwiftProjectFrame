//
//  BaseVM.swift
//  VeSync
//
//  Created by Sheldon on 2019/8/9.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import Foundation

/// 支持输入输出的ViewModel要遵从的协议, 为编写更加容易测试的ViewModel
protocol ViewModelType {
    /// View的输入事件等，比如下拉刷新，点击选择事件，输入框输入事件等等一切View的触发事件
    associatedtype Input
    /// 输出给View的可观察属性，比如View的一些状态值，显示到View的数据源
    associatedtype Output
    /// 根据输入ViewModel转化处理后输出，该方法为ViewModel处理逻辑封装，也是单元测试要测试的ViewModel的代码
    func transform(input: Input) -> Output
}

class BaseVM: NSObject {
    /// Rx资源回收包
    let disposeBag = DisposeBag()
    /// 错误管道，可以把需要统一处理的错误输入进来
    let error = ErrorTracker()

    override init() {
        super.init()
        error.asDriver().drive(onNext: {[weak self] (error) in
            logDebug("[view model \(type(of: self)) error]: \(error)")
        }).disposed(by: disposeBag)
    }

    deinit {
        logDebug("\(type(of: self)): Deinited")
        logResourcesCount()
    }
}

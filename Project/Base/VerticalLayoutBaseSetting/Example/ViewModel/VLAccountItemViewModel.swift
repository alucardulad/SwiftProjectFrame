//
//  VLAccountItemViewModel.swift
//  Assureapt
//
//  Created by HET on 2019/12/26.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit

class VLAccountItemViewModel: VLBaseItemViewModel {

    let accountImageName: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    let accountName: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    let makeMoneyValue: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    let makeMoneyFunctionValue: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    let integrationValue: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    let integrationFunciton: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    var accountSubject: PublishSubject<Void>?
    var makeMoneySubject: PublishSubject<Void>?
    var integrationSubject: PublishSubject<Void>?
    
    init(accountName: String,
         accountImageName: String,
         makeMoney: Double,
         integration: Double,
         accountSubject: PublishSubject<Void>? = nil,
         makeMoneySubject: PublishSubject<Void>? = nil,
         integrationSubject: PublishSubject<Void>? = nil) {
        super.init(itemSupportClassName: VLAccountTableViewCell.self,
                   height: kScaleHeight(100))
        self.accountName.accept(accountName)
        self.accountImageName.accept(accountImageName)
        self.makeMoneyValue.accept("￥\(makeMoney)")
        self.makeMoneyFunctionValue.accept("收益".localized)
        self.integrationValue.accept("\(integration)")
        self.integrationFunciton.accept("积分".localized)
        self.accountSubject = accountSubject
        self.makeMoneySubject = makeMoneySubject
        self.integrationSubject = integrationSubject
    }
}

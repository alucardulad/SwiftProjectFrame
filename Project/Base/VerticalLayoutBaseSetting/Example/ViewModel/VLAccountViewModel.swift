//
//  VLAccountViewModel.swift
//  Assureapt
//
//  Created by HET on 2019/12/26.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit

class VLAccountViewModel: VLBaseViewModel {
    let accountSubject = PublishSubject<Void>()
    let makeMoneySubject = PublishSubject<Void>()
    let integrationSubject = PublishSubject<Void>()
}

extension VLAccountViewModel {
    //items配置以及其他数据配置(在init调用)
    override func configurateInstance() {
        super.configurateInstance()
        
        self.items = [[VLAccountItemViewModel(accountName: "爱生活，爱打扫",
                                              accountImageName: "example_account_icon",
                                              makeMoney: 520,
                                              integration: 5200,
                                              accountSubject: accountSubject,
                                              makeMoneySubject: makeMoneySubject,
                                              integrationSubject: integrationSubject)],
                      [VLMessageItemViewModel(topCornerMsg: "邀请好友赢不停".localized),
                       VLMessageItemViewModel(msg: "常见问题".localized),
                       VLMessageItemViewModel(bottomCornerMsg: "问题反馈".localized)],
                      [VLMessageItemViewModel(topCornerMsg: "用户协议".localized),
                       VLMessageItemViewModel(bottomCornerMsg: "使用手册".localized)]]
    }
}

//
//  AppDelegate+SwitchRootVC.swift
//  Assureapt
//
//  Created by HET on 2020/1/2.
//  Copyright © 2020 Etekcity. All rights reserved.
//

extension AppDelegate {
    
    func settingAPPRootVC() {
        testVLLayoutRootVC()
    }
    
    private func testVLLayoutRootVC() {
        let testVC = VLAccountViewController()
        testVC.viewModel = VLAccountViewModel()
        testVC.navigator = Navigator()
        let testNaVC = UINavigationController(rootViewController: testVC)
        self.window?.rootViewController = testNaVC
    }
}

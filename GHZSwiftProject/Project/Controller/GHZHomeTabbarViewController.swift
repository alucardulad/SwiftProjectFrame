//
//  GHZHomeTabbarViewController.swift
//  GHZSwiftProject
//
//  Created by HET on 2019/12/3.
//  Copyright © 2019 GHZ. All rights reserved.
//

import UIKit

class GHZHomeTabbarViewController: UITabBarController {
    
    var tabBarViewControllers: [UIViewController]!
    var tabBarItems: [UITabBarItem]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInstance()
        setupUI()
    }
    
    func setupUI() {
        self.tabBar.barTintColor = JWMacro.JWUIColorFromRGB(0xF5F4F2)
        self.tabBar.tintColor = JWMacro.JWUIColorFromRGB(0xEB3349)
        self.tabBar.backgroundColor = JWMacro.JWUIColorFromRGB(0xF5F4F2)
        self.viewControllers = self.tabBarViewControllers
        self.tabBar.isTranslucent = false
    }
    
    func setupInstance() {
        
        if tabBarItems == nil {
            tabBarItems = [UITabBarItem(title: "设备", image: UIImage(named: "device_normal"),
                                        selectedImage: UIImage(named: "device_select")),
                           UITabBarItem(title: "商城", image: UIImage(named: "shop_normal"),
                                        selectedImage: UIImage(named: "shop_select")),
                           UITabBarItem(title: "资讯", image: UIImage(named: "news_normal"),
                                        selectedImage: UIImage(named: "news_select")),
                           UITabBarItem(title: "我的", image: UIImage(named: "mine_normal"),
                                        selectedImage: UIImage(named: "mine_select"))]
        }
        
        if tabBarViewControllers == nil {
            let deviceVC = GHZMyDeviceListViewController()
            deviceVC.tabBarItem? = tabBarItems[0]
            let deviceNaVC = UINavigationController(rootViewController: deviceVC)
            
            let shopVC = GHZShopViewController()
            shopVC.tabBarItem? = tabBarItems[1]
            let shopNaVC = UINavigationController(rootViewController: shopVC)
            
            let newsVC = GHZNewsViewController()
            newsVC.tabBarItem? = tabBarItems[2]
            let newNavc = UINavigationController(rootViewController: newsVC)
            
            let mineVC = GHZMineViewController()
            mineVC.tabBarItem? = tabBarItems[3]
            let mineNaVC = UINavigationController(rootViewController: mineVC)
            tabBarViewControllers = [deviceNaVC, shopNaVC, newNavc, mineNaVC]
        }
    }
}

//
//  NoDataDefaultView.swift
//  VeSync
//
//  Created by Sheldon on 2019/9/28.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit

enum NoDataType: String {
    case base = "illustrationBaseNoData"
    
    func getTip() -> String {
        switch self {
        case .base:
            return "No data yet"
        }
    }
}

// MARK: - 常量
private struct Metric {
    static let topMargin = kScaleHeight(120)
    static let tipMargin = kScaleHeight(16)
}

class NoDataDefaultView: UIView {
    
    /// 无数据视图创建
    ///
    /// - Parameters:
    ///   - frame: 尺寸
    ///   - tip: 提示文本
    ///   - type: 提示类型
    convenience init(frame: CGRect, type: NoDataType = .base) {
        self.init()
        self.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        setupUI(type: type)
    }
    
    private func setupUI(type: NoDataType) {
        backgroundColor = .white
        let img = UIImageView().then {
            $0.image = UIImage(named: type.rawValue)
            addSubview($0)
        }
        let label = UILabel().then {
            $0.text = type.getTip()
            $0.textColor = kHexColor(0x666666)
            $0.font = kSystemRegularFont(15)
            addSubview($0)
        }
        img.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(Metric.topMargin)
        }
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(img.snp_bottom).offset(Metric.tipMargin)
        }
    }
    
}

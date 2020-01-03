//
//  VLMessageTableViewCell.swift
//  Assureapt
//
//  Created by HET on 2019/12/26.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit

class VLMessageTableViewCell: VLBaseTableViewCell {
    
    var showContenView: UIView?
    var msgLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //数据填充以及处理
    override func bind(to itemViewModel: VLBaseItemViewModel?) {
        super.bind(to: itemViewModel)
        
        guard (itemViewModel as? VLMessageItemViewModel) != nil else {
            return
        }
        let valueData = itemViewModel as! VLMessageItemViewModel

        valueData.msg.asObservable().bind(to: msgLabel!.rx.text).disposed(by: disposeBag)
        cornerRadius(topLeft: valueData.isCornerRadiusTopLeft,
                     topRight: valueData.isCornerRadiusTopRight,
                     bottomLeft: valueData.isCornerRadiusBottomLeft,
                     bottomRight: valueData.isCornerRadiusBottomRight)
    }
    
    func cornerRadius(topLeft: Bool,
                      topRight: Bool,
                      bottomLeft: Bool,
                      bottomRight: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            var value: UInt = 0
            if topLeft { value = value | UIRectCorner.topLeft.rawValue }
            if topRight { value = value | UIRectCorner.topRight.rawValue }
            if bottomLeft { value = value | UIRectCorner.bottomLeft.rawValue }
            if bottomRight { value = value | UIRectCorner.bottomRight.rawValue }
            let maskPath = UIBezierPath(roundedRect: self.showContenView!.bounds,
                                        byRoundingCorners: UIRectCorner(rawValue: value),
                                        cornerRadii: CGSize(width: 4, height: 4))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.showContenView!.bounds
            maskLayer.path = maskPath.cgPath
            self.showContenView?.layer.mask = maskLayer
        }
    }
}

extension VLMessageTableViewCell {
    // MARK: - Cell的页面配置链
    override func configurateEvents() {
        super.configurateEvents()
        
    }
    // UI对象 其他操作
    override func configurateUI () {
        super.configurateUI()
        
    }
    // UI对象 addSubview和UI布局
    override func layoutUIInstance() {
        super.layoutUIInstance()
        
        self.addSubview(self.showContenView!)
        self.showContenView?.addSubview(self.msgLabel!)
        
        showContenView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp_left).offset(kScaleWidth(10))
            make.right.equalTo(self.snp_right).offset(-kScaleWidth(10))
            make.top.bottom.equalTo(self)
        })
        
        msgLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.showContenView!.snp_left).offset(kScaleWidth(20))
            make.right.equalTo(self.snp_right).offset(-kScaleWidth(40))
            make.top.bottom.equalTo(self)
        })
    }
    // UI对象 实例化
    override func configurateInstance() {
        super.configurateInstance()
        
        self.showContenView = UIView()
        showContenView?.backgroundColor = kHexColor(0xFAFAFA)
        showContenView?.clipsToBounds = true
        
        self.msgLabel = UILabel()
        msgLabel?.textColor = kHexColor(0x323232)
        msgLabel?.font = kSystemRegularFont(13)
    }
}

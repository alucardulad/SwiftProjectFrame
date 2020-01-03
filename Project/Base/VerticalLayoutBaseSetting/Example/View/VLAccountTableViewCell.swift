//
//  VLAccountTableViewCell.swift
//  Assureapt
//
//  Created by HET on 2019/12/26.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit
import RxSwift

class VLAccountTableViewCell: VLBaseTableViewCell {
    
    var accountImageView: UIImageView?
    var accountLabel: UILabel?
    var makeMoneyValueLabel: UILabel?
    var makeMoneyFunctionLabel: UILabel?
    var integrationValueLabel: UILabel?
    var integrationFunctionLable: UILabel?
    var spaceLine: UIView?
    var accountBtn: UIButton?
    var makeMoneyBtn: UIButton?
    var integrationBtn: UIButton?
    
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

        guard (itemViewModel as? VLAccountItemViewModel) != nil else {
            return
        }
        let itemViewModel: VLAccountItemViewModel = itemViewModel as! VLAccountItemViewModel
        
        itemViewModel.accountName.bind(to: self.accountLabel!.rx.text).disposed(by: disposeBag)
        itemViewModel.makeMoneyFunctionValue.bind(to: self.makeMoneyFunctionLabel!.rx.text).disposed(by: disposeBag)
        itemViewModel.makeMoneyValue.bind(to: self.makeMoneyValueLabel!.rx.text).disposed(by: disposeBag)
        itemViewModel.integrationFunciton.bind(to: self.integrationFunctionLable!.rx.text).disposed(by: disposeBag)
        itemViewModel.integrationValue.bind(to: self.integrationValueLabel!.rx.text).disposed(by: disposeBag)
        
        if let subject = itemViewModel.accountSubject {
            self.accountBtn!.rx.tap.bind(to: subject).disposed(by: disposeBag)
        }
        if let subject = itemViewModel.makeMoneySubject {
            self.makeMoneyBtn?.rx.tap.bind(to: subject).disposed(by: disposeBag)
        }
        if let subject = itemViewModel.integrationSubject {
            self.integrationBtn?.rx.tap.bind(to: subject).disposed(by: disposeBag)
        }
    }
}

extension VLAccountTableViewCell {
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
        
        self.addSubview(accountImageView!)
        self.addSubview(accountLabel!)
        self.addSubview(makeMoneyValueLabel!)
        self.addSubview(makeMoneyFunctionLabel!)
        self.addSubview(integrationValueLabel!)
        self.addSubview(integrationFunctionLable!)
        self.addSubview(spaceLine!)
        self.addSubview(accountBtn!)
        self.addSubview(makeMoneyBtn!)
        self.addSubview(integrationBtn!)
        
        accountImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp_left).offset(kScaleWidth(50))
            make.top.equalTo(self.snp_top).offset(kScaleHeight(5))
            make.width.height.equalTo(kScaleHeight(63))
        })
        
        accountLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.accountImageView!.snp_bottom).offset(kScaleHeight(5))
            make.bottom.equalTo(self.snp_bottom)
            make.width.equalTo(kScaleHeight(100))
            make.centerX.equalTo(self.accountImageView!)
        })
        
        makeMoneyValueLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.spaceLine!.snp_left).offset(-kScaleWidth(10))
            make.top.equalTo(self.snp_top).offset(kScaleHeight(29))
            make.width.equalTo(kScaleWidth(82))
        })
        
        makeMoneyFunctionLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.makeMoneyValueLabel!)
            make.top.equalTo(self.makeMoneyValueLabel!.snp_bottom).offset(kScaleHeight(5))
        })
        
        integrationValueLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.spaceLine!.snp_right).offset(kScaleWidth(10))
            make.top.equalTo(self.snp_top).offset(kScaleHeight(29))
            make.width.equalTo(kScaleWidth(82))
        })
        
        integrationFunctionLable?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.integrationValueLabel!)
            make.top.equalTo(self.integrationValueLabel!.snp_bottom).offset(kScaleHeight(5))
        })
        
        spaceLine!.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp_right).offset(-kScaleWidth(120))
            make.top.equalTo(self.snp_top).offset(kScaleHeight(23))
            make.width.equalTo(kScaleWidth(1))
            make.height.equalTo(kScaleHeight(48))
        }
        
        accountBtn?.snp.makeConstraints({ (make) in
            make.left.top.right.equalTo(self.accountImageView!)
            make.bottom.equalTo(self.accountLabel!)
        })
        
        makeMoneyBtn?.snp.makeConstraints({ (make) in
            make.left.top.right.equalTo(self.makeMoneyValueLabel!)
            make.bottom.equalTo(self.makeMoneyFunctionLabel!)
        })
        
        integrationBtn?.snp.makeConstraints({ (make) in
            make.left.top.right.equalTo(self.integrationValueLabel!)
            make.bottom.equalTo(self.integrationFunctionLable!)
        })
    }
    // UI对象 实例化
    override func configurateInstance() {
        super.configurateInstance()
        
        self.accountImageView = UIImageView()
        accountImageView?.contentMode = .scaleAspectFit
        
        self.accountLabel = UILabel()
        accountLabel?.textColor = kHexColor(0xFFFFFF)
        accountLabel?.font = kSystemRegularFont(10)
        accountLabel?.textAlignment = .center
        accountLabel?.numberOfLines = 0
        
        self.makeMoneyValueLabel = UILabel()
        makeMoneyValueLabel?.textColor = kHexColor(0xFFFFFF)
        makeMoneyValueLabel?.textAlignment = .center
        makeMoneyValueLabel?.font = kSystemBoldFont(18)
        
        self.makeMoneyFunctionLabel = UILabel()
        makeMoneyFunctionLabel?.textColor = kHexColor(0xFFFFFF)
        makeMoneyFunctionLabel?.font = kSystemRegularFont(12)
        
        self.integrationValueLabel = UILabel()
        integrationValueLabel?.textColor = kHexColor(0xFFFFFF)
        integrationValueLabel?.textAlignment = .center
        integrationValueLabel?.font = kSystemBoldFont(18)
        
        self.integrationFunctionLable = UILabel()
        integrationFunctionLable?.textColor = kHexColor(0xFFFFFF)
        integrationFunctionLable?.font = kSystemRegularFont(12)
        
        self.spaceLine = UIView()
        spaceLine?.backgroundColor = kHexColor(0x8B8B8B)
        
        self.accountBtn = UIButton()
        self.makeMoneyBtn = UIButton()
        self.integrationBtn = UIButton()
    }
}

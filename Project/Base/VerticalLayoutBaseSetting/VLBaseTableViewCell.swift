//
//  VLBaseTableViewCell.swift
//  Assureapt
//
//  Created by HET on 2019/12/4.
//  Copyright © 2019 GHZ. All rights reserved.
//

import UIKit
import RxSwift

class VLBaseTableViewCell: UITableViewCell {
    
    var lineView: UIView?
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configurateUI()
        configurateEvents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //保证 cell 被重用的时候不会被多次订阅，避免错误发生。
        disposeBag = DisposeBag()
    }
}

// MARK: - cell的配置链
extension VLBaseTableViewCell {
    @objc func bind(to itemViewModel: VLBaseItemViewModel?) {
        guard itemViewModel != nil else {
            return
        }
        lineView?.isHidden = !(itemViewModel!.isLine)
        self.bringSubviewToFront(lineView!)
    }
    
    @objc func configurateEvents() {
        
    }
    
    @objc func configurateUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        configurateInstance()
        layoutUIInstance()
    }
    
    @objc func layoutUIInstance() {
        self.addSubview(lineView!)
        
        lineView?.snp.makeConstraints({ (make) in
            make.height.equalTo(kScaleHeight(1))
            make.left.equalTo(self.snp_left).offset(kScaleWidth(17))
            make.right.equalTo(self.snp_right).offset(-kScaleWidth(17))
            make.bottom.equalTo(self.snp_bottom)
        })
    }
    
    @objc func configurateInstance() {
        self.lineView = UIView()
        lineView?.backgroundColor = UIColor(red: 0xdd/255.0,
                                            green: 0xdc/255.0,
                                            blue: 0xdf/255.0,
                                            alpha: 1)
        lineView?.isHidden = true
    }
}

//
//  GHZStatusTableViewCell.swift
//  GHZSwiftProject
//
//  Created by HET on 2019/12/4.
//  Copyright © 2019 GHZ. All rights reserved.
//

import UIKit

class GHZStatusTableViewCell: JWBaseTableViewCell {

    var deviceImageView: UIImageView?
    var nameLabel: UILabel?
    var statusLabel: UILabel?
    var rightArrowImageView: UIImageView?
    var statusContentView: UIView?
    var contentImageView: UIImageView?
    var testLabel: JWLabel?
    var testButton: JWButton?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    override func setupUI () {
        super.setupUI()
        
    }
    
    override func layoutUIInstance() {
        super.layoutUIInstance()
        
        deviceImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.statusContentView!.snp.left).offset(JWMacro.frame_base_width(14.0))
            make.centerY.equalTo(self.statusContentView!)
            make.height.equalTo(JWMacro.frame_base_height(45.0))
        })
        
        nameLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.statusContentView!.snp.left).offset(JWMacro.frame_base_width(84.0))
            make.right.equalTo(self.statusContentView!.snp.right).offset(-JWMacro.frame_base_width(84.0))
            make.top.equalTo(self.statusContentView!.snp.top).offset(JWMacro.frame_base_height(11.0))
            make.bottom.equalTo(self.statusContentView!.snp.bottom).offset(-JWMacro.frame_base_height(11.0))
        })
        
        statusLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.rightArrowImageView!.snp.left).offset(-JWMacro.frame_base_width(12.0))
            make.centerY.equalTo(self.statusContentView!)
        })
        
        rightArrowImageView?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.statusContentView!.snp.right).offset(-JWMacro.frame_base_width(11.0))
            make.centerY.equalTo(self.statusContentView!)
        })
        
        statusContentView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left).offset(JWMacro.frame_base_width(10.0))
            make.right.equalTo(self.snp.right).offset(-JWMacro.frame_base_width(10.0))
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
        })
        
        contentImageView?.snp.makeConstraints({ (make) in
            make.left.right.top.bottom.equalTo(self.statusContentView!)
        })
    }
    
    override func setupInstance() {
        super.setupInstance()
        
        self.deviceImageView = UIImageView(image: UIImage(named: "saodi_device_icon"))
        deviceImageView?.contentMode = .scaleAspectFit
        self.nameLabel = UILabel()
        nameLabel?.text = "扫地机器人"
        nameLabel?.textColor = JWMacro.JWUIColorFromRGB(0x323232)
        nameLabel?.font = UIFont.systemFont(ofSize: 15.0)
        nameLabel?.numberOfLines = 0
        self.statusLabel = UILabel()
        statusLabel?.text = "在线"
        statusLabel?.font = UIFont.systemFont(ofSize: 13.0)
        self.rightArrowImageView = UIImageView(image: UIImage(named: "right_arrow_1"))
        self.statusContentView = UIView()
        self.contentImageView = UIImageView(image: UIImage(named: "item_white_bg"))
        contentImageView?.contentMode = .scaleToFill
        
        self.addSubview(self.statusContentView!)
        self.statusContentView?.addSubview(contentImageView!)
        self.statusContentView?.addSubview(deviceImageView!)
        self.statusContentView?.addSubview(nameLabel!)
        self.statusContentView?.addSubview(statusLabel!)
        self.statusContentView?.addSubview(rightArrowImageView!)
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

}

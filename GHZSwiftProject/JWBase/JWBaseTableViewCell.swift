//
//  JWBaseTableViewCell.swift
//  GHZSwiftProject
//
//  Created by HET on 2019/12/4.
//  Copyright © 2019 GHZ. All rights reserved.
//

import UIKit

class JWBaseTableViewCell: UITableViewCell {
    
    var lineView: UIView?
    
    func updateData(cellData: JWBaseItemViewModel) {
        
    }
    
    func setupEvents() {
        
    }
    
    func setupRacSignal() {
        
    }
    
    func setupUI() {
        setupInstance()
        layoutUIInstance()
    }
    
    func layoutUIInstance() {
        
    }
    
    func setupInstance() {
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupEvents()
        setupRacSignal()
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

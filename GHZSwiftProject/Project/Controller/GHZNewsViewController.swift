//
//  GHZNewsViewController.swift
//  GHZSwiftProject
//
//  Created by HET on 2019/12/3.
//  Copyright © 2019 GHZ. All rights reserved.
//

import UIKit

class GHZNewsViewController: JWBaseViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func leftBarButtonItemClick(_ button: UIButton) {
        
    }
    
    override func rightBarButtonItemClick(_ button: UIButton) {
        
    }
    
    override func setupEvents() {
        
    }
    
    override func setupRacSignal() {
        
    }
    
    override func setupUI() {
        super.setupUI()
        
        self.view.addSubview(self.tableView!)
        
        self.tableView?.snp.makeConstraints({ (make) in
            make.bottom.left.right.equalTo(self.view)
            make.top.equalTo(self.jwNavigationBar.snp_bottomMargin)
        })
    }
    
    override func setupInstance() {
        super.setupInstance()
        
        self.tableView = UITableView()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.tableFooterView = UIView()
        tableView?.backgroundColor = UIColor.clear
        tableView?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
    }
    
    override func setupNaviegationBar() {
        self.jwSetRightBarItemImage(UIImage(named: "add_icon"))
        self.jwSetNavigationBar(title: "资讯")
    }
    
    // MARK: - tablview的delegate和DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}

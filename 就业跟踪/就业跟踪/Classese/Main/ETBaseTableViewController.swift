//
//  ETBaseTableViewController.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/18.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit
import MJRefresh

/// 基类tableView控制器：封装下拉刷新
class ETBaseTableViewController: UIViewController {

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    // 适配iPhoneX
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if #available(iOS 11.0, *) {
            print(view.safeAreaInsets.top)
            
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:  UIApplication.shared.statusBarFrame.height + 44, right: 0)
        }
    }
    
    /// 添加下拉刷新
    func addPullRefresh() {
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0)
        tableView.showsVerticalScrollIndicator = false
        
        tableView.mj_header = MJRefreshNormalHeader() {
            self.loadData()
        }
        
    }

    /// 加载数据
    func loadData() {
        
    }
}

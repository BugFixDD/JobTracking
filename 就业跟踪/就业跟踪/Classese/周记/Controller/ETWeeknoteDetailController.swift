//
//  ETWeeknoteDetailController.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/15.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

/// 周记详细页面内容cell重用ID
let ETWeeknoteDetailContentCellReusedID = "ETWeeknoteDetailCellReusedID"
/// 周记详细页面评论Cell重用ID
let ETWeeknoteDetailCommentCellReusedID = "ETWeeknoteDetailCommentCellReusedID"
/// 周记详细控制器
class ETWeeknoteDetailController: UIViewController {

    /// 周记模型
    var weeknoteModel: ETWeeknoteModel?
    
    var tableVw: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // 适配iPhoneX
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if #available(iOS 11.0, *) {
            print(view.safeAreaInsets.top)
            
            tableVw.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:  UIApplication.shared.statusBarFrame.height + 44, right: 0)
        }
    }
}

// MARK: - 表格的数据源和代理
extension ETWeeknoteDetailController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reusedID = indexPath.section == 0 ? ETWeeknoteDetailContentCellReusedID : ETWeeknoteDetailCommentCellReusedID
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reusedID, for: indexPath) as! ETWeeknoteDetailCell
        
        cell.weeknoteModel = weeknoteModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? nil : "评语"
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

// MARK: - 设置UI
extension ETWeeknoteDetailController {
    func setupUI() {
        tableVw = UITableView(frame: view.bounds, style: .plain)
        tableVw.delegate = self
        tableVw.dataSource = self
        tableVw.rowHeight = UITableViewAutomaticDimension
        tableVw.estimatedRowHeight = 500
        tableVw.separatorStyle = .none
        tableVw.allowsSelection = false
        
        let contentNib = UINib(nibName: "ETWeeknoteDetailCell", bundle: nil)
        tableVw.register(contentNib, forCellReuseIdentifier: ETWeeknoteDetailContentCellReusedID)
        let commentNib = UINib(nibName: "ETWeeknoteDetailCommentCell", bundle: nil)
        tableVw.register(commentNib, forCellReuseIdentifier: ETWeeknoteDetailCommentCellReusedID)
        
        view.addSubview(tableVw)
    }
}

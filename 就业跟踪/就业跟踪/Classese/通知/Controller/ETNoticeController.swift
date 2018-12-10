//
//  ETNoticeController.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/15.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit
import YYModel

/// cell重用id
let NoticeCellReusedID = "NoticeCellReusedID"

/// 通知模块的根控制器
class ETNoticeController: ETBaseTableViewController {

    var dataSouce: ETDataSource!
    
    lazy var present = ETNoticePresent()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        addPullRefresh()
        tableView.mj_header.beginRefreshing()
        
        dataSouce = ETDataSource(reusedID: NoticeCellReusedID) { (cell, model, indexPath) in
            guard let cell = cell as? ETNoticeCell,
                let model = model as? ETNoticeModel else {
                    return
            }
            
            cell.titleLbl.text = model.title
            cell.contentLbl.text = model.content
            cell.timeLbl.text = model.createtime
            
        }

        tableView.dataSource = dataSouce
    }

    /// 加载数据
    override func loadData() {
        present.loadData {
            self.tableView.mj_header.endRefreshing()
            
            guard let dataList = self.present.dataList else { return }
            self.dataSouce.addDataList(dataList: dataList)
            self.tableView.reloadData()
        }
    }
}

// MARK: - tableView数据源和代理
extension ETNoticeController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ETNoticeDetailController()
        vc.noticeModel = present.dataList?[indexPath.row]

        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - 设置UI
extension ETNoticeController {
    func setupUI() {
        var frame = CGRect.zero
        if #available(iOS 11.0, *) {
            frame = view.safeAreaLayoutGuide.layoutFrame
        } else {
            frame = view.bounds
        }
        
        tableView = UITableView(frame: frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = dataSouce
        tableView.register(UINib(nibName: "ETNoticeCell", bundle: nil), forCellReuseIdentifier: NoticeCellReusedID)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
    }
}

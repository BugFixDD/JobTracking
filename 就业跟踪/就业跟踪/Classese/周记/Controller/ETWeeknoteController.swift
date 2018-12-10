//
//  ETWeeknoteController.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/14.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

let ETWeeknoteCellReusedID = "ETWeeknoteCellReusedID"
/// 周记模块的根控制器
class ETWeeknoteController: ETBaseTableViewController {

    /// 周记模型数组
    lazy var weekNoteList = [ETWeeknoteModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        addPullRefresh()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if weekNoteList.count == 0 {
            tableView.mj_header.beginRefreshing()
        }
        if ETLoginModel.shared.isLogin == false {
            navigationController?.pushViewController(ETLoginController(), animated: true)
        }
    }
    
    override  func loadData() {
        guard let userID = ETLoginModel.shared.userName else {
            tableView.mj_header.endRefreshing()
            return
        }
        ETNetworkingManager.shared.personalWeeknote(userID: userID) { (object, isSucceed) in
            
            self.tableView.mj_header.endRefreshing()
            
            // FIXME: 还有要判断网路是否联通
            if isSucceed == false {
//                self.navigationController?.pushViewController(ETLoginController(), animated: true)
                return
            }
            
            guard let object = object,
                let weeknotes = NSArray.yy_modelArray(with: ETWeeknoteModel.self, json: object) as? [ETWeeknoteModel] else {
                return
            }
            
            self.weekNoteList = weeknotes
            self.tableView.reloadData()
        }
    }
    
    @objc private func composeItemClick() {
        let vc = ETComposeWeeknoteController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - 表格的数据源和代理
extension ETWeeknoteController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekNoteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ETWeeknoteCellReusedID) as! ETWeeknoteCell
        
        cell.model = weekNoteList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ETWeeknoteDetailController()
        
        vc.weeknoteModel = weekNoteList[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - 设置UI
extension ETWeeknoteController {
    func setupUI() {
        
        let composeItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(composeItemClick))
        
        navigationItem.rightBarButtonItem = composeItem
        
        setupTableVw()
    }
    
    func setupTableVw() {
        let tableVw = UITableView(frame: view.bounds, style: .plain)
        tableVw.delegate = self
        tableVw.dataSource = self
        let nib = UINib(nibName: "ETWeeknoteCell", bundle: nil)
        tableVw.register(nib, forCellReuseIdentifier: ETWeeknoteCellReusedID)
        tableVw.rowHeight = 105
        tableVw.separatorStyle = .none
        tableVw.showsVerticalScrollIndicator = false
        
        view.addSubview(tableVw)
        tableView = tableVw
    }

}

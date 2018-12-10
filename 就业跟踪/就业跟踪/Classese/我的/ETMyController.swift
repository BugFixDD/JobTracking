//
//  ETMyController.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/17.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

/// 我的cell重用ID
let ETMyCellReusedID = "ETMyCellReusedID"
/// 我的模块根控制器
class ETMyController: UIViewController {

    var tableVw: UITableView!
    
    /// 我的组模型数组
    lazy var myGroupModels = [ETMyGroupModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableVw.reloadData()
    }
    
    //MARK: 点击cell调用的方法
    /// 上传就业协议方法
    @objc func uploadEmploymentProtocol() {
        OperationQueue().addOperation {
            let vc = ETEmploymentProtocol()
            
            OperationQueue.main.addOperation({
                self.navigationController?.pushViewController(vc, animated: true)
            })
        }
        
    }
    
    /// 登陆或退出登陆
    @objc func loginOrLogout() {
        ETLoginModel.shared.userName = nil
        ETLoginModel.shared.passWord = nil
        ETLoginModel.shared.isLogin = false
        ETLoginModel.shared.save()
        
        let vc = ETLoginController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 写周记
    @objc func composeWeeknote() {
        let vc = ETComposeWeeknoteController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadData() {
        guard let path = Bundle.main.path(forResource: "My.plist", ofType: nil),
            let array = NSArray(contentsOfFile: path),
            let list = NSArray.yy_modelArray(with: ETMyGroupModel.self, json: array) as? [ETMyGroupModel] else {
            return
        }
        
        myGroupModels += list
        tableVw.reloadData()
    }

}

// MARK: - 表格数据源和代理
extension ETMyController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return myGroupModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroupModels[section].models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableVw.dequeueReusableCell(withIdentifier: ETMyCellReusedID, for: indexPath)

        guard let model = myGroupModels[indexPath.section].models?[indexPath.row] else {
            return cell
        }
        
        cell.textLabel?.text = model.title// myModelList[indexPath.section].title
        cell.textLabel?.textColor = ETGrayColor
        cell.textLabel?.font = UIFont.systemFont(ofSize: 19)
        
        if model.isLoginCell == true {
            cell.textLabel?.text = ETLoginModel.shared.isLogin == true ? "退出登陆": "登陆"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = myGroupModels[indexPath.section].models?[indexPath.row],
            let methodName = model.methodName else {
            return
        }
        
        let sel = NSSelectorFromString(methodName)
        perform(sel)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

// MARK: - 设置UI
extension ETMyController {
    func setupUI() {
        tableVw = UITableView(frame: view.bounds, style: .grouped)
        tableVw.delegate = self
        tableVw.dataSource = self
        tableVw.register(UITableViewCell.self, forCellReuseIdentifier: ETMyCellReusedID)
        tableVw.sectionFooterHeight = 0
        
        view.addSubview(tableVw)
    }
}

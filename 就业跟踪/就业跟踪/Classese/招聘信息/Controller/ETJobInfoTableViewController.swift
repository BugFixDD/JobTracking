///Users/lsy/new_employment_tracking/九江职业技术学院就业跟踪/九江职业技术学院就业跟踪/Classese/招聘信息/Controller/ETJobInfoTableViewController.swift
//  ETJobInfoTableViewController.swift
//  九江职业技术学院就业跟踪
//
//  Created by  罗仕宇 on 2018/6/14.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit
import AwesomeMenu

 let jobInfoCallId = "jobInfoCallId"

class ETJobInfoTableViewController: ETBaseTableViewController, AwesomeMenuItemDelegate {
    
    var startItem: AwesomeMenuItem?
    let AwesomeMenuX: CGFloat = UIScreen.main.bounds.width - CGFloat(54)
    let AwesomemenuY: CGFloat = UIScreen.main.bounds.height - CGFloat(120)
    
    func awesomeMenuItemTouchesBegan(_ item: AwesomeMenuItem!) {
        
    }
    
    func awesomeMenuItemTouchesEnd(_ item: AwesomeMenuItem!) {
        let vc = ETJobInfoSearch()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    private lazy var listViewModel = ETJobInfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
        addPullRefresh()
        tableView.mj_header.beginRefreshing()
        
        setupAwesomeMenu()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if #available(iOS 11.0, *) {
            startItem?.frame = CGRect(x: view.safeAreaLayoutGuide.layoutFrame.width - 64, y: view.safeAreaLayoutGuide.layoutFrame.height - 64, width: 64, height: 64)
        }
        
    }
    
    /// 测试浮动按钮
    func setupAwesomeMenu() {
        //        let ETContentViewWidth: CGFloat = UIScreen.main.bounds.width -
        
        let imageN = UIImage(named: "search")
        let imageH = UIImage(named: "search")
        let imageC = UIImage(named: "background")
        let imageCH = UIImage(named: "background")
        startItem = AwesomeMenuItem(
            image: imageC,
            highlightedImage: imageCH,
            contentImage: imageN,
            highlightedContentImage: imageH)
        startItem?.delegate = self
        
        
        startItem?.layer.shadowColor = ETGrayColor.cgColor
        startItem?.layer.shadowOpacity = 0.8
        startItem?.layer.shadowRadius = 5.0
        startItem?.layer.shadowOffset = CGSize(width: 0, height: 1)
        startItem?.frame = CGRect(x: AwesomeMenuX, y: AwesomemenuY, width: 64, height: 64)
        self.view.addSubview(startItem!)
        
    }
    
    override func loadData() {
        listViewModel.loadJobInfoList { (isSuccess) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.reloadData()
        }
    }
}

extension ETJobInfoTableViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.jobInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModel = listViewModel.jobInfoList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: jobInfoCallId, for: indexPath) as! ETJobInfoCell
        
        cell.viewModel = viewModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ETSpecificJobInfoViewController()
        
        let id = listViewModel.jobInfoList[indexPath.row].id
        
        listViewModel.loadSpecificJobInfo(id: id, completion: {(isSuccess) in
            vc.SpecificJobInfo = self.listViewModel.specificJobInfo[0]
            self.navigationController?.pushViewController(vc, animated: true)
        })
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

private extension ETJobInfoTableViewController {
    func setupTableView() {
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: jobInfoCallId)
        var frame = CGRect.zero
        if #available(iOS 11.0, *) {
            frame = view.safeAreaLayoutGuide.layoutFrame
        } else {
            frame = view.bounds
        }
        
        tableView = UITableView(frame: frame, style: .plain)
        tableView.register(UINib(nibName: "ETJobInfoCell", bundle: nil), forCellReuseIdentifier: jobInfoCallId)
        tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 300
        
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }
}

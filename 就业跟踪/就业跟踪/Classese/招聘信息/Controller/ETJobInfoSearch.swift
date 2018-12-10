//
//  ETJobInfoSearch.swift
//  九江职业技术学院就业跟踪
//
//  Created by  罗仕宇 on 2018/6/21.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

private let jobInfoSearch = "jobInfoSearchCallId"

var searchText: String?

class ETJobInfoSearch: UIViewController {
    lazy var filerArray = NSMutableArray()
    var tableView: UITableView!
    var groups: NSArray?
    var searchBar: UISearchBar!

    private lazy var jobInfo = ETJobInfoViewModel()
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        setUI()
        
        jobInfo.loadJobInfoList { (isSuccess) in
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
    }
    
}

// MARK: - uitableView 代理和数据源方法
extension ETJobInfoSearch: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.text?.count == 0 {
            return 0
        }
        return self.filerArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.filerArray[indexPath.row] as! ETJobInfo
        
        let cell = tableView.dequeueReusableCell(withIdentifier: jobInfoSearch, for: indexPath)as! ETJobInfoSearchCell
        
        if searchBar.text?.count == 0 {
            return  UITableViewCell()
        }else {
            cell.ViewModel = model
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ETSpecificJobInfoViewController()
        let model = self.filerArray[indexPath.row] as! ETJobInfo
        let id = model.id
        self.searchBar.resignFirstResponder()
        
        jobInfo.loadSpecificJobInfo(id: id, completion: {(isSuccess) in
            vc.SpecificJobInfo = model
            self.navigationController?.pushViewController(vc, animated: true)
        })
        
    }
}

// MARK: - 搜索栏 代理方法
extension ETJobInfoSearch: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        heandleSearch(searchTerm: searchText)
    }
    
    func heandleSearch(searchTerm: String) {
        if self.searchBar.text?.count == 0 {
            self.tableView.reloadData()
        }else {
            self.filerArray.removeAllObjects()
            
            for  job in jobInfo.jobInfoList {
                let str1 = job.job_name?.uppercased()
                let str2 = searchTerm.uppercased()
                
                if (str1?.contains(str2))! {
                    searchText = str2
                    self.filerArray.add(job)
                }
            }
        }
        self.tableView.reloadData()
    }
}

// MARK: - 设置UI
extension ETJobInfoSearch {
    func setUI() {
        self.view.backgroundColor = UIColor.white
        
        searchBar = UISearchBar()
        
        searchBar.frame = CGRect(
            x: 0,
            y: 7,
            width: UIScreen.main.bounds.width - 64,
            height: 32)
        searchBar.placeholder = "搜索"
        
        let searchView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: searchBar.frame.width,
            height: 44))
        searchView.addSubview(searchBar)
        self.navigationItem.titleView = searchView
        searchBar.delegate = self
        
        setTableView()
    }
    
    func setTableView () {
        self.tableView = UITableView(frame: view.bounds, style: .plain)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ETJobInfoSearchCell", bundle: nil),
                                forCellReuseIdentifier: jobInfoSearch)
        
        let v = UIView()
        
        self.tableView.tableFooterView = v
        
        
        
        self.view.addSubview(self.tableView)
    }
    
}

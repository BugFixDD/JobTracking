//
//  ETDataSource.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/7/29.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit



typealias ETConfigCellBlock = (UITableViewCell, NSObject, IndexPath) -> ()

class ETDataSource: NSObject, UITableViewDataSource {
    
    var configCellBlock: ETConfigCellBlock
    var reusedID: String
    
    private var dataList = [NSObject]()
    
    init(reusedID: String, block: @escaping ETConfigCellBlock) {
        configCellBlock = block
        self.reusedID = reusedID
    }
    
    func addDataList(dataList: [ETNoticeModel]) {
        self.dataList = dataList
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reusedID, for: indexPath)
        
        configCellBlock(cell, dataList[indexPath.row], indexPath)
        
        return cell
    }
    
    
}

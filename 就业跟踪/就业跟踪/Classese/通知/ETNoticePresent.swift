//
//  ETNoticePresent.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/7/29.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit



class ETNoticePresent: NSObject {
    
    var dataList: [ETNoticeModel]?
    
    func loadData(completion: @escaping () -> ()) {
        ETNetworkingManager.shared.notices { (object, isSucceed) in
            
            // FIXME: 还有要判断网路是否联通
            if isSucceed == false {
                // 提示用户
                return
            }
            
            guard let object = object,
                let noticeList = NSArray.yy_modelArray(with: ETNoticeModel.self, json: object) as? [ETNoticeModel] else {
                    return
            }
            
            self.dataList = noticeList
            completion()
        }
    }
}

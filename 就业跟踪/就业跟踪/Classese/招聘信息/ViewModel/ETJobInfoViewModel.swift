//
//  ETJobInfoViewModel.swift
//  九江职业技术学院就业跟踪
//
//  Created by  罗仕宇 on 2018/6/14.
//  Copyright © 2018年 BF. All rights reserved.
//

import Foundation

class ETJobInfoViewModel {
    lazy var jobInfoList = [ETJobInfo]()
    lazy var specificJobInfo = [ETJobInfo]()
    
    func loadJobInfoList(completion: @escaping (Bool) -> ()) {
        ETNetworkingManager.shared.jobInfos { (list, isSuccess) in
            guard let array = NSArray.yy_modelArray(with: ETJobInfo.self, json: list ?? []) as? [ETJobInfo] else{
                completion(isSuccess)
                return
            }
            self.jobInfoList += array
            
            completion(isSuccess)
        }
    }
    
    func loadSpecificJobInfo(id:Int, completion:@escaping(Bool) -> ()) {
        ETNetworkingManager.shared.specificJobInfo(jobID: id) { (Info, isSuccess) in
            guard let model = ETJobInfo.yy_model(with: Info as! [AnyHashable : Any]) else {
                completion(isSuccess)
                return
            }
            
            self.specificJobInfo = [model]
            
            print(self.specificJobInfo)
            
            completion(isSuccess)
        }
    }
}

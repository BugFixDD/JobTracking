//
//  ETNetworkingManager.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/13.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD

/// 负责这个软件的所有网络相关的东西
class ETNetworkingManager: AFHTTPSessionManager {
    
    init() {
        super.init(baseURL: URL(string: "http://baoxiu.jvtc.jx.cn/"), sessionConfiguration: nil)
        
        responseSerializer.acceptableContentTypes = (NSSet(objects: "application/json", "text/json", "text/javascript", "text/html") as! Set<String>)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 单例
    static let shared = ETNetworkingManager()
    
    /// get请求
    ///
    /// - Parameters:
    ///   - urlString: urlString
    ///   - parameters: parameters
    ///   - completion: (返回数据，请求网路是否成功)
    func GET(urlString: String, parameters: Any? = nil, completion: @escaping (Any?, Bool) -> ()) {
        
        get(urlString, parameters: parameters, progress: nil, success: { (task, responseObject) in
            print("\n-------url：" ,task.response?.url)
            completion(responseObject, true)
            
        }) { (task, error) in
            print(error)
            
            SVProgressHUD.ET_showInfo(text: "请检查网络设置")
            completion(nil, false)
        }
    }
}

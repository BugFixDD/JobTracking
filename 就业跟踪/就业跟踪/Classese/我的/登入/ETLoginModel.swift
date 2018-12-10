//
//  ETLoginModel.swift
//  九江职业技术学院就业跟踪
//
//  Created by  罗仕宇 on 2018/6/20.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

class ETLoginModel: NSObject {
    
    @objc var userName: String?
    
    @objc var passWord: String?
    
    @objc var isLogin: Bool = false
    
    static let shared = ETLoginModel()
    
    func save() {
        saveArray(userName: userName ?? "", passWord: passWord ?? "", isLogin: isLogin)
    }
    
    /// 缓存用户名，密码
    ///
    /// - Parameters:
    ///   - userName: 用户名
    ///   - password: 密码
    func saveArray(userName: String, passWord: String, isLogin: Bool) {
        let home = NSHomeDirectory()
        let docPath = (home as NSString).strings(byAppendingPaths: ["Documents"])
        
        let data: NSArray = [["userName":userName,
                              "password":passWord,
                              "isLogin":isLogin]]
        
        let filepath = (docPath.first! as NSString).strings(byAppendingPaths: ["data.plist"])
        
        print(filepath)
        
        data.write(toFile: filepath.first!, atomically: true)
        
    }
    
    
    /// 读取数据
    func read() {
        let home = NSHomeDirectory()
        
        let docPath = (home as NSString).strings(byAppendingPaths: ["Documents"])
        
        let filePath = (docPath.first! as NSString).strings(byAppendingPaths: ["data.plist"])
        
        guard let data = NSArray(contentsOfFile: filePath.first!) else{
            return
        }
        print("123", filePath)
        for m in data as! [[String: AnyObject]] {
            let b = m["isLogin"] as! Bool
            
            isLogin = b
            if b {
                userName = m["userName"] as? String
                passWord = m["password"] as? String
            }
        }
        print(ETLoginModel.shared)
    }
}

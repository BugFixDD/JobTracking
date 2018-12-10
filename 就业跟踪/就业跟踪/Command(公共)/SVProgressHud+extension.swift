//
//  SVProgressHud+extension.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/17.
//  Copyright © 2018年 BF. All rights reserved.
//

import SVProgressHUD

enum ETLogin {
    case Success
    case Error
}

extension SVProgressHUD {
    /// 显示某某为空：如协议书编号为空
    ///
    /// - Parameter text:
    class func ET_showEmptyInfo(text: String) {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.showInfo(withStatus: text + "为空")
        SVProgressHUD.dismiss(withDelay: 1)
    }
    
   
    /// 显示成功消息，一秒钟后消失
    ///
    /// - Parameters:
    ///   - text:
    ///   - completion: 消失完成走的回调
    class func ET_showSucceed(text: String, completion: (() -> ())?) {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.showSuccess(withStatus: text)
        SVProgressHUD.dismiss(withDelay: 1) {
            completion?()
        }
    }
    
    /// 显示信息，一秒钟后消失
    ///
    /// - Parameter text:
    class func ET_showInfo(text: String) {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.showInfo(withStatus: text)
        SVProgressHUD.dismiss(withDelay: 1)
    }
    
    class func ET_showLogin(Login: ETLogin = .Success, text:String, completion:@escaping () -> () ) {
        if Login == .Error {
            SVProgressHUD.showError(withStatus: text)
            SVProgressHUD.dismiss(withDelay: 1, completion: {
                completion()
            })
        }else{
            SVProgressHUD.showSuccess(withStatus: text)
            SVProgressHUD.dismiss(withDelay: 1, completion: {
                completion()
            })
        }
        
    }
}

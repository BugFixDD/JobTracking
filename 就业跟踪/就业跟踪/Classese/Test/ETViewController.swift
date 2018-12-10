//
//  ETViewController.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/13.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit
import AFNetworking

// 测试D
// 测试2D
class ETViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.orange
        
//        let urlString = "http://baoxiu.jvtc.jx.cn/ydgw/weeknote_ajaxsave.htm"
//        let parameters = ["title": "你好", "createtime": "2018", "content": "测试", "userid": "79200958"]
//        ETNetworkingManager.shared.GET(urlString: urlString, parameters: parameters) { (object, isSucceed) in
//            print(object)
//        }
        
//        ETNetworkingManager.shared.post(urlString, parameters: parameters, constructingBodyWith: { (formData) in
//
//        }, progress: nil, success: { (task, responseObject) in
//            print(responseObject)
//        }) { (task, error) in
//            print(error)
//        }
        

        ETNetworkingManager.shared.login(userName: "79200958", password: "123456") { (isSucceed, _) in
            print(isSucceed)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

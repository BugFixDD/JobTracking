//
//  RootViewController.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/13.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

/// 根控制器：最顶层的控制器
class ETRootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let path = Bundle.main.path(forResource: "ControllerInfomation.plist", ofType: nil),
            let infoDicts = NSArray(contentsOfFile: path) as? [[String: String]] else {
            return
        }
        
        view.backgroundColor = UIColor.white
        
        setTabbar(info: infoDicts)

    }
    
    /// 设置tababr和子控制器
    ///
    /// - Parameter info: 子控制器的相关信息
    func setTabbar(info: [[String: String]]) {
        
        var viewControllers = [UIViewController]()
        
        for dict in info {
            guard let cName = dict["ControllerName"],
                let clsName = cName.insertPrefixString(),
                let imgName = dict["imgName"],
                let tName = dict["titleName"],
                let cls = NSClassFromString(clsName) as? UIViewController.Type else {
                    continue
            }
            
            let vc = cls.init()
            let navC = ETNavigationController(rootViewController: vc)
            
            viewControllers += [navC]
            
            vc.title = tName
            vc.tabBarItem.image = UIImage(named: imgName)?.adjustImageSize(size: CGSize(width: 30, height: 30), isShowCornerRadius: true)?.originImage()
        }
        
        setViewControllers(viewControllers, animated: false)
    }

    //        let infoDict = [["ControllerName": "ViewController", "imgName": "notice", "titleName": "通知" ],
    //                        ["ControllerName": "ViewController", "imgName": "job", "titleName": "招聘信息" ],
    //                        ["ControllerName": "ViewController", "imgName": "weeknotelist", "titleName": "周记" ],
    //                        ["ControllerName": "ViewController", "imgName": "practice", "titleName": "就业协议书" ],
    //                        ["ControllerName": "ViewController", "imgName": "", "titleName": "设置" ]]
}

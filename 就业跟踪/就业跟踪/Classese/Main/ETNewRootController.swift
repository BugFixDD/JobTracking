//
//  ETNewRootController.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/19.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit
import WMPageController

/// ETChangeViewControllerNotificationName的info字典里面的key
let ETIsShowWeeknoteInfoKey = "ETIsShowWeeknoteInfoKey"
/// 更改ViewController的通知名字
let ETChangeViewControllerNotificationName = "changeViewControllerNotificationName"
/// 新的根控制器
class ETNewRootController: WMPageController {

    let menuViewHeight: CGFloat = 44
    
    /// 上一个滚的控制器的索引
    var lastIndex = 0
    /// 将要显示的viewcontroller的index
    var willShowIndex = 0
    
    class func newRootController() -> ETNewRootController {

        guard let path = Bundle.main.path(forResource: "ControllerInfomation.plist", ofType: nil),
            let infoDicts = NSArray(contentsOfFile: path) as? [[String: String]] else {
                return ETNewRootController()
        }
        
        guard let vcClasses = viewControllerClasses(infos: infoDicts),
            let titles = titles(infos: infoDicts) else {
            
            return ETNewRootController()
        }
        let vc = ETNewRootController(viewControllerClasses: vcClasses, andTheirTitles: titles)

        vc.setupProperties()
        
        return vc
    }
    
    class func titles(infos: [[String: String]]) -> [String]? {
        var titles = [String]()
        
        for dict in infos {
            guard let titleN = dict["titleName"] else {
                    continue
            }
            titles += [titleN]
        }
        
        return titles
    }
    
    class func viewControllerClasses(infos: [[String: String]]) -> [UIViewController.Type]? {
  
        var viewControlelrClasses = [UIViewController.Type]()
        for dict in infos {
            guard let cName = dict["ControllerName"],
                let clsName = cName.insertPrefixString(),
                let cls = NSClassFromString(clsName) as? UIViewController.Type else {
                    continue
            }
            
            viewControlelrClasses += [cls]
        }
        
        
        return viewControlelrClasses
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = NSNotification.Name(rawValue: ETChangeViewControllerNotificationName)
        NotificationCenter.default.addObserver(self, selector: #selector(changeViewController), name: name, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func changeViewController(n: Notification) {
        
        if ETLoginModel.shared.isLogin == true {
            selectIndex = Int32(willShowIndex)
            
        } else {
            selectIndex = Int32(lastIndex)
        }

    }
    
    /// 设置相关属性
    func setupProperties() {
        menuViewStyle = .line
        showOnNavigationBar = true
        titleSizeNormal = 18
        titleSizeSelected = 22

        titleColorSelected = ETBlueColor
        titleColorNormal = ETGrayColor
        
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect(x: 0, y: 20, width: view.bounds.width, height: menuViewHeight)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        return CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    }
    
    override func pageController(_ pageController: WMPageController, willEnter viewController: UIViewController, withInfo info: [AnyHashable : Any]) {
        let idx = (info["index"] as? Int) ?? 0
        willShowIndex = idx
        
        
        if viewController.isKind(of: ETWeeknoteController.self) {
            return
        }

        lastIndex = idx


    }


}

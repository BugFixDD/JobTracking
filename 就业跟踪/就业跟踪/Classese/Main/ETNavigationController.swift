//
//  ETNavigationController.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/13.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

/// 根控制器(ETRootViewController)下的导航控制器
class ETNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationBar.isHidden = true
        navigationBar.setBackgroundImage(UIImage.colorBackgroundImage(color: UIColor.white), for: .default)

        navigationBar.tintColor = ETBlueColor
        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .normal)
    }


    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 隐藏tabbar
        if (childViewControllers.count > 0) {
            viewController.hidesBottomBarWhenPushed = true

        }
        
        super.pushViewController(viewController, animated: animated)
        childViewControllers.first?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

}

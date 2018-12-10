//
//  UIDevice+exetnsion.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/7/2.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

extension UIDevice {
    /// 判断是否是iPhoneX
    ///
    /// - Returns: 
    public func isiPhoneX() -> Bool {
        
        if UIScreen.main.bounds.height == 812 {
            
            return true
            
        }
        return false
    }
}



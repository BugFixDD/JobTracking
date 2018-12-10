//
//  String+Category.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/13.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

extension String {
    

    /// 插入前缀字符串：命名空间和项目前缀
    ///
    /// - Returns: String
    func insertPrefixString() -> String? {
        guard let bundleName = Bundle.main.infoDictionary?["CFBundleName"] as? String else {
            return nil
        }
        return bundleName + "." + "ET" + self
    }
    
    /// 根据宽计算字符串的大小
    ///
    /// - Parameter width: 宽
    /// - Returns: 大小
    func boundingSize(width: CGFloat, font: UIFont) -> CGSize {
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))

        return (self as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil).size 
    }
    
    func changeLineSpace() {
        
    }
    
}

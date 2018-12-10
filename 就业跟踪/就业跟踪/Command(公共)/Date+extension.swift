//
//  Date+extension.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/20.
//  Copyright © 2018年 BF. All rights reserved.
//

import Foundation

extension Date {
    /// 根据格式返回时间字符串
    ///
    /// - Parameter format: 时间格式：如yyyy/MM/dd
    /// - Returns: 
    func stringForCurrentDate(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }

}

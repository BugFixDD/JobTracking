//
//  ETMyModel.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/17.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

/// 我的模型
class ETMyModel: NSObject {
    /// 单元格标题
    @objc var title: String?
    /// 点击这个单元格调用的方法名
    @objc var methodName: String?
    /// 是不是登陆单元格
    @objc var isLoginCell: Bool = false
}

//
//  ETMyGroupModel.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/19.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

/// my的模块组模型
class ETMyGroupModel: NSObject {
    /// ETMyModel数组
    @objc var models: [ETMyModel]?
    
    @objc class func modelContainerPropertyGenericClass() -> [String: Any] {
        return ["models": ETMyModel.self]
    }
}

//
//  ETJobInfo.swift
//  九江职业技术学院就业跟踪
//
//  Created by  罗仕宇 on 2018/6/14.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit
import YYModel

class ETJobInfo: NSObject {
    /// 企业名
    @objc var enterprise_name: String?
    /// id
    @objc var id: Int = 0
    /// 工资范围
    @objc var job_wage: String?
    /// 职业
    @objc var job_name: String?
    /// 发布时间
    @objc var publish_date: String?
    /// 应聘要求
    @objc var job_desp: String? {
        didSet{
            let fontSize = UIFont.boldSystemFont(ofSize: 15)
            let txtH = job_desp?.boundingSize(width: ETContentViewWidth, font: fontSize).height ?? 0
            
            textHeight = txtH
        }
    }
    
    var textHeight: CGFloat = 0
    
    override var description: String{
        return yy_modelDescription()
    }
}

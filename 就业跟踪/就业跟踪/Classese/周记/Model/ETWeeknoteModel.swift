//
//  ETWeeknoteModel.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/15.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

/// 周记模型
class ETWeeknoteModel: NSObject {
    
    /// 周记id
    @objc var id: String?
    /// 标题
    @objc var title: String?
    /// 内容
    @objc var content: String?
    /// 时间
    @objc var createtime: String?
    /// 老师名
    @objc var teacher_name: String?
    /// 学生名
    //@objc var student_name: String?
    /// 学生所在的班级名
    //@objc var className: String?
    /// 评语
    @objc var comment: String?
}

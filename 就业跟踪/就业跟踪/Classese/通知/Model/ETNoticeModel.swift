//
//  ETNoticeModel.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/15.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

/// 通知模型
@objc class ETNoticeModel: NSObject {
    
    /// 通知id
    @objc var id: Int = 0
    /// 通知内容
    @objc var content: String? {
        didSet {
            let textH: CGFloat = content?.boundingSize(width: ETContentViewWidth, font: ETContentFont).height ?? 0
            textHeight = textH
        }
    }
    /// 通知的创建时间
    @objc var createtime: String?
    /// 通知标题
    @objc var title: String? {
        didSet {
            let titleH: CGFloat = title?.boundingSize(width: ETContentViewWidth, font: ETTitleFont).height ?? 0
            titleHeight = titleH
        }
    }
    /// 老师名字/发布人
    @objc var teacher_name: String?
    
    /// 标题的高度
    var titleHeight: CGFloat = 0
    /// 内容的高度
    var textHeight: CGFloat = 0
}

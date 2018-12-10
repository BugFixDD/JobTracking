//
//  ETNoticeCell.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/15.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

class ETNoticeCell: UITableViewCell {
    
    

    /// 标题label
    @IBOutlet weak var titleLbl: UILabel!
    
    /// 内容label
    @IBOutlet weak var contentLbl: UILabel!
    
    /// 时间label
    @IBOutlet weak var timeLbl: UILabel!
    
//    var noticeModel: ETNoticeModel? {
//        didSet {
//            titleLbl.text = noticeModel?.title
//            contentLbl.text = noticeModel?.content
//            timeLbl.text = noticeModel?.createtime
//            
//        }
//    }

}

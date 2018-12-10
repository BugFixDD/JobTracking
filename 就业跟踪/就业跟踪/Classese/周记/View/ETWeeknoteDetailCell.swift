//
//  ETWeeknoteDetailCell.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/15.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

/// 周记详细页面cell
class ETWeeknoteDetailCell: UITableViewCell {
    /// 周记模型
    var weeknoteModel: ETWeeknoteModel? {
        didSet {
            titleLbl?.text = weeknoteModel?.title
            contentLbl?.text = weeknoteModel?.content
            
            if let content = weeknoteModel?.content {
                let attString = NSMutableAttributedString(string: content)
                let paragraphStyle =  NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 10
                let range = NSRange(location: 0, length: attString.length)
                attString.yy_setLineSpacing(10, range: range)
                contentLbl?.attributedText = attString
            }
            
            timeLbl?.text = weeknoteModel?.createtime
            if let teacherName = weeknoteModel?.teacher_name {
                teacherNameLbl?.text = teacherName + ":"
            }
            commentContentLbl?.text = weeknoteModel?.comment
        }
    }
    
    /// 标题label
    @IBOutlet weak var titleLbl: UILabel?
    /// 内容label
    @IBOutlet weak var contentLbl: UILabel?
    /// 时间label
    @IBOutlet weak var timeLbl: UILabel?

    /// 老师名字label
    @IBOutlet weak var teacherNameLbl: UILabel?
    /// 评论内容label
    @IBOutlet weak var commentContentLbl: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

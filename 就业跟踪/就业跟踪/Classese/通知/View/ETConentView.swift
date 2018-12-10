//
//  ETConentView.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/15.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit
import YYText

/// 边距
let ETContentViewMargin: CGFloat = 15
/// ContentView的宽度
let ETContentViewWidth: CGFloat = UIScreen.main.bounds.width - ETContentViewMargin * 2
/// ContentView内容正文字体
let ETContentFont = UIFont.systemFont(ofSize: 20)
/// ContentView标题字体
let ETTitleFont = UIFont.boldSystemFont(ofSize: 30) //.systemFont(ofSize: 30)

/// 显示内容的view
class ETConentView: UIScrollView {

    /// 通知模型
    var noticeModel: ETNoticeModel? {
        didSet {
            titleLbl.text = noticeModel?.title
            let teacherN = noticeModel?.teacher_name ?? ""
            teacherLbl.text = "发布人:" + teacherN
            textLabel.text = noticeModel?.content
            if let content = noticeModel?.content {
                let attString = NSMutableAttributedString(string: content)
                let paragraphStyle =  NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 10
                let range = NSRange(location: 0, length: attString.length)
                attString.yy_setLineSpacing(10, range: range)
                textLabel.attributedText = attString
            }
            
            timeLbl.text = noticeModel?.createtime
        }
    }
    
    /// 标题label
    private var titleLbl: UILabel!
    /// 发布人label
    private var teacherLbl: UILabel!
    /// 内容label
    private var textLabel: UILabel!
    /// 时间label
    private var timeLbl: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        showsVerticalScrollIndicator = false
        
        titleLbl = UILabel(lines: 0)
        titleLbl.font = ETTitleFont
        addSubview(titleLbl)
        
        teacherLbl = UILabel()
        addSubview(teacherLbl)
        
        textLabel = UILabel(lines: 0)
        textLabel.font = ETContentFont
        addSubview(textLabel)

        timeLbl = UILabel(textColor: UIColor.black, fontSize: 18, alignment: .right) // UILabel(alignment: .right)
        addSubview(timeLbl)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLbl.frame = CGRect(x: ETContentViewMargin, y: ETContentViewMargin, width: ETContentViewWidth, height: noticeModel?.titleHeight ?? 0)
        
        teacherLbl.frame = CGRect(x: ETContentViewMargin, y: titleLbl.frame.maxY + ETContentViewMargin * 2, width: 0, height: 0)
        teacherLbl.sizeToFit()
        
        textLabel.frame = CGRect(x: ETContentViewMargin, y: teacherLbl.frame.maxY + ETContentViewMargin, width: ETContentViewWidth, height: 0)
        textLabel.sizeToFit()

        timeLbl.sizeToFit()
        timeLbl.frame = CGRect(x: bounds.width - timeLbl.bounds.width - ETContentViewMargin * 2, y: textLabel.frame.maxY + ETContentViewMargin * 5, width: timeLbl.bounds.width, height: timeLbl.bounds.height)
        
        contentSize = CGSize(width: 0, height: timeLbl.frame.maxY + ETContentViewMargin + 64)
    }

}

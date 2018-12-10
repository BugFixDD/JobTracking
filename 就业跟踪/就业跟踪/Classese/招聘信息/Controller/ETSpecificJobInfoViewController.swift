//
//  ETloadSpecificJobInfoViewController.swift
//  九江职业技术学院就业跟踪
//
//  Created by  罗仕宇 on 2018/6/15.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

let ETTextH: CGFloat = 30

class ETSpecificJobInfoViewController: UIViewController {

    lazy var SpecificJobInfo = ETJobInfo()
    
    var id : Int = 0
    var scrollView = UIScrollView()

    /// 公司名
    private var enterpriseLbl: UILabel!
    /// 工作
    private var jobLbl: UILabel!
    /// 工作名
    private var jobName: UILabel!
    /// 工资范围
    private var jobWageLbl: UILabel!
    /// 任职要求
    private var jobdespLbl: UILabel!
    /// 发布时间
    private var jobdate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setUI()
    }
    
    // 适配iPhoneX
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if #available(iOS 11.0, *) {
            
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
        }
    }
    
}

private extension ETSpecificJobInfoViewController {
    func setUI() {
        var frame = CGRect.zero
        if #available(iOS 11.0, *) {
            frame = view.safeAreaLayoutGuide.layoutFrame
        } else {
            frame = view.bounds
        }
        
        scrollView = UIScrollView(frame: frame)
        self.view.addSubview(scrollView)
        
        enterpriseLbl = UILabel()
        enterpriseLbl?.text = SpecificJobInfo.enterprise_name
        enterpriseLbl.font = UIFont(name: "Helvetica-Bold", size: 20)
        scrollView.addSubview(enterpriseLbl)
        
        jobLbl = UILabel()
        jobLbl.text = SpecificJobInfo.job_name
        scrollView.addSubview(jobLbl)
        
        jobWageLbl = UILabel()
        jobWageLbl.text = SpecificJobInfo.job_wage
        jobWageLbl.textColor = ETOrangeColor
        scrollView.addSubview(jobWageLbl)
        
        jobdate = UILabel()
        jobdate.text = SpecificJobInfo.publish_date
        jobdate.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(jobdate)
        
        jobdespLbl = UILabel()
        let str = "岗位要求:  \n\(SpecificJobInfo.job_desp ?? "")"
        jobdespLbl.attributedText = getAttributedString(
            string: str,
            lineSpace: 10)
//        jobdespLbl.attributedText = getAttributedString(
//            string: SpecificJobInfo.job_desp!,
//            lineSpace: 10)
        jobdespLbl.numberOfLines = 0
        scrollView.addSubview(jobdespLbl)
        
        computeUI()
    }
    
    func computeUI() {
        enterpriseLbl.frame = CGRect(
            x: ETContentViewMargin,
            y: ETContentViewMargin,
            width: ETContentViewWidth,
            height: ETTextH)
        
        jobLbl.frame = CGRect(
            x: ETContentViewMargin,
            y: enterpriseLbl.frame.maxY,
            width: ETContentViewWidth,
            height: ETTextH)
        
        jobWageLbl.frame = CGRect(
            x: ETContentViewMargin,
            y: jobLbl.frame.maxY,
            width: ETContentViewWidth,
            height: ETTextH)
        
        jobdate.frame = CGRect(
            x: ETContentViewMargin,
            y: jobWageLbl.frame.maxY,
            width: ETContentViewWidth,
            height: ETTextH)

        jobdespLbl.frame = CGRect(
            x: ETContentViewMargin,
            y: jobdate.frame.maxY + ETContentViewMargin,
            width: ETContentViewWidth,
            height: SpecificJobInfo.textHeight)
        jobdespLbl.sizeToFit()
        
        scrollView.contentSize = CGSize(width: 0, height: jobdespLbl.frame.maxY + 64 + ETContentViewMargin)
    }
    
    func getAttributedString(string: String, lineSpace: CGFloat) -> (NSAttributedString) {
        let attr = NSMutableAttributedString.init(string: string)
        let paragraph = NSMutableParagraphStyle.init()
        paragraph.lineSpacing = lineSpace
        let range = NSMakeRange(0, string.count)
        attr.addAttribute(
            NSAttributedStringKey.paragraphStyle,
            value: paragraph,
            range: range)
        
        return attr
    }
}

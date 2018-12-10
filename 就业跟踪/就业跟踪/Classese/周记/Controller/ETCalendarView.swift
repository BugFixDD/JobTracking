//
//  ETcalendar.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/20.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit
import FSCalendar

/// 显示日历的view
class ETCalendarView: UIView {

    /// 选中日期的回调，把时间传过去
    var selectDate: ((Date) -> ())?
    
    /// 日历view
    lazy var calendar = FSCalendar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func show() {
        if let rootVw = UIApplication.shared.keyWindow?.rootViewController?.view {
            frame = rootVw.bounds
            alpha = 0
            rootVw.addSubview(self)
            UIView.animate(withDuration: 0.25, animations: {
                self.alpha = 1
            })
        }
        
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
        }, completion: { (_) in
            self.removeFromSuperview()
        })

    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss()
    }
}

// MARK: - 设置页面
extension ETCalendarView {
    func setupUI() {
        //        backgroundColor = UIColor.lightGray
        setupMaskView()
        
        setupCalendar()
    }
    
    func setupCalendar() {
        calendar.delegate = self
        calendar.locale = Locale(identifier: "zh_CN")
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.backgroundColor = UIColor.white
        calendar.layer.cornerRadius = 5
        calendar.layer.shadowColor = UIColor.black.cgColor
        calendar.layer.shadowOffset = CGSize(width: 3, height: 3)
        calendar.layer.shadowOpacity = 1
        
        addSubview(calendar)
        calendar.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(snp.width).multipliedBy(0.7)
        }
    }
    
    func setupMaskView() {
        let maskVw = UIView()
        maskVw.backgroundColor = UIColor.black
        maskVw.alpha = 0.6
        addSubview(maskVw)
        
        maskVw.translatesAutoresizingMaskIntoConstraints = false
        maskVw.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(-64)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
    

//MARK: 日历组件代理
extension ETCalendarView: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        selectDate?(date)
        dismiss()
    }
}

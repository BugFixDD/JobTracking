//
//  ETComposeWeeknoteController.swift
//  添加周记
//
//  Created by student on 2018/6/14.
//  Copyright © 2018年 student. All rights reserved.
//

import UIKit
import YYText
import SnapKit
import SVProgressHUD

/// 撰写周记控制器
class ETComposeWeeknoteController: UIViewController {

    /// 标题textfield
    lazy var titleTF = UITextField()
    
    /// 虚线分割线
    lazy var dottedVw = ETDottedView()
    
    /// 正文textview
    lazy var articleTV = YYTextView()
    
    /// 选择日期按钮
    lazy var selectTimeBtn = UIButton(type: .system)
    /// 日期label
    var timeLbl: UILabel!
    
    /// 发布按钮
    lazy var composeBtn = UIButton(type: .custom)
    
    /// 统计字数item
    var wordCountItem: UIBarButtonItem!
    
    /// 日历view
    lazy var calendarView = ETCalendarView()
    
    let margin: CGFloat = 15
    var contentWidth: CGFloat {
        return view.bounds.width - 2 * margin
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        observeKeyboard()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.viewSafeAreaInsetsDidChange()
            
            if UIDevice.current.isiPhoneX() == false {
                return
            }

            let bottomMargin: CGFloat = -(margin + view.safeAreaInsets.bottom)
            composeBtn.snp.updateConstraints({ (make) in
                make.bottom.equalTo(bottomMargin)
            })

  
        }
        
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        composeBtn.gradientLayer.frame = composeBtn.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
    }
    
    /// 监听键盘弹出事件
    func observeKeyboard() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

    //MARK: 监听按钮的点击事件
    @objc func composeBtnClick() {
        if composeBtn.isSelected == true {
            view.endEditing(true)
            composeBtn.isSelected = false

        } else {
            if checkHasEmpty() == true {
                return
            }
            
            // TODO: 上传数据到服务器
            SVProgressHUD.ET_showSucceed(text: "发布成功") {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        
    }
    @objc func selectTimeBtnClick() {
        if composeBtn.isSelected == true {
            composeBtnClick()
        }
        
        calendarView.show()
    }
    
    /// 检查是否有空的文本框
    ///
    /// - Returns:
    func checkHasEmpty() -> Bool {
        if titleTF.hasText == false {
            SVProgressHUD.ET_showEmptyInfo(text: "标题")
            return true
        }
        
        if articleTV.hasText == false {
            SVProgressHUD.ET_showEmptyInfo(text: "正文")
            return true
        }
        
        return false
    }
    
    @objc private func keyboardChangeFrame(n: Notification) {
        
        guard let frame = n.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect else {
            return
        }
        
        composeBtn.isSelected = true
        
        let height: CGFloat = frame.origin.y - UIApplication.shared.statusBarFrame.height - 44
        UIView.animate(withDuration: 0.25) {
            self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y, width: self.view.bounds.width, height: height)
        }
        
    }
}

// MARK: - textView代理
extension ETComposeWeeknoteController: YYTextViewDelegate {
    func textViewDidBeginEditing(_ textView: YYTextView) {
        let wordCount = textView.text.count
        wordCountItem.title = "\(wordCount)字"
    }
    
    func textViewDidChange(_ textView: YYTextView) {
        let wordCount = textView.text.count
        wordCountItem.title = "\(wordCount)字"
    }
}

// MARK: - 设置页面
extension ETComposeWeeknoteController {
    func setupUI() {
        
        view.backgroundColor = UIColor.white
        setupRightItem()
        
        setupTitleTextField()
        
        setupSeperatorLine()
        
        setupArticleTextView()
        
        setupTimePartion()
        
        setupComposeBtn()
        
        setupCalendarView()
    }
   
    func setupRightItem() {
        
        wordCountItem = UIBarButtonItem(title: "0字", style: .plain, target: nil, action: nil)
        wordCountItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black], for: .normal)
        
        navigationItem.rightBarButtonItem = wordCountItem
    }
    
    func setupTitleTextField() {
        titleTF.borderStyle = .none
        titleTF.placeholder = "请输入标题"
        titleTF.font = UIFont.systemFont(ofSize: 30)
        //titleTF.backgroundColor = UIColor.red
        view.addSubview(titleTF)
        
        titleTF.translatesAutoresizingMaskIntoConstraints = false
        titleTF.snp.makeConstraints { (make) in
            make.top.left.equalTo(margin)
            make.right.equalTo(view).offset(-margin)
            make.height.equalTo(64)
        }
    }
    
    func setupSeperatorLine() {
        
        dottedVw.backgroundColor = UIColor.white
        dottedVw.dottedColor = ETBlueColor
        
        view.addSubview(dottedVw)
        dottedVw.translatesAutoresizingMaskIntoConstraints = false
        dottedVw.snp.makeConstraints { (make) in
            make.top.equalTo(titleTF.snp.bottom)
            make.height.equalTo(10)
            make.left.right.equalTo(titleTF)
        }
    }
    
    func setupArticleTextView() {
        
        articleTV.placeholderText = "请输入正文"
        articleTV.font = UIFont.systemFont(ofSize: 20)
        articleTV.placeholderFont = articleTV.font
        //articleTV.backgroundColor = UIColor.yellow
        view.addSubview(articleTV)
        articleTV.translatesAutoresizingMaskIntoConstraints = false
        articleTV.snp.makeConstraints { (make) in
            make.top.equalTo(dottedVw.snp.bottom)
            make.left.right.equalTo(dottedVw)
        }

        articleTV.delegate = self
    }
    
    func setupTimePartion() {
        
        selectTimeBtn.setTitle(Date().stringForCurrentDate(format: "yyyy/MM/dd"), for: .normal)
        selectTimeBtn.setTitleColor(ETBlueColor, for: .normal)
        selectTimeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        view.addSubview(selectTimeBtn)
        selectTimeBtn.translatesAutoresizingMaskIntoConstraints = false
        selectTimeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(articleTV.snp.bottom).offset(margin * 2)
            make.right.equalTo(articleTV)
        }
        selectTimeBtn.addTarget(self, action: #selector(selectTimeBtnClick), for: .touchUpInside)
        
        timeLbl = UILabel(text: "日期:", textColor: UIColor.black, fontSize: 15)
        view.addSubview(timeLbl)
        timeLbl.translatesAutoresizingMaskIntoConstraints = false

        timeLbl.snp.makeConstraints { (make) in
            make.centerY.equalTo(selectTimeBtn)
            make.right.equalTo(-130)
        }
    }
    
    func setupComposeBtn() {
//        composeBtn.backgroundColor = ETBlueColor
        composeBtn.setTitle("发布", for: .normal)
        composeBtn.setTitle("完成", for: .selected)
        composeBtn.setTitleColor(UIColor.white, for: .normal)
        composeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        composeBtn.layer.cornerRadius = 5
        composeBtn.addTarget(self, action: #selector(composeBtnClick), for: .touchUpInside)
        composeBtn.addGradientBackgroundColor()
        
        
        view.addSubview(composeBtn)
        composeBtn.translatesAutoresizingMaskIntoConstraints = false
        composeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(selectTimeBtn.snp.bottom).offset(margin)
            make.left.right.equalTo(articleTV)
            make.bottom.equalTo(-margin)
            make.height.equalTo(40)
        }
    }
    

    func setupCalendarView() {
        calendarView.selectDate = { (date: Date) in
            let dateString = date.stringForCurrentDate(format: "yyyy/MM/dd")
            self.selectTimeBtn.setTitle(dateString, for: .normal)
        }
    }
}

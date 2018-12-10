//
//  ETNoticeDetailController.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/15.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

/// 通知的详细控制器
class ETNoticeDetailController: UIViewController {
    
    /// 通知模型
    var noticeModel: ETNoticeModel?
    
    /// 显示内容的view
    private var contentView: ETConentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        contentView.noticeModel = noticeModel
    }
    
    // 适配iPhoneX
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if #available(iOS 11.0, *) {
            
            contentView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
        }
    }

}

// MARK: - 设置UI
extension ETNoticeDetailController {
    func setupUI() {
        
        view.backgroundColor = UIColor.white
        
        setupContentView()
    }
    
    func setupContentView() {
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        contentView = ETConentView(frame: frame)
//        contentView.backgroundColor = ETTincColor
        
        view.addSubview(contentView)
    }
    
}

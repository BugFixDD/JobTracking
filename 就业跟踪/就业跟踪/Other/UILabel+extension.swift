//
//  UILabel+extension.swift
//  Weibo3
//
//  Created by 树清吴 on 2017/12/8.
//  Copyright © 2017年 shuQingWu. All rights reserved.
//

import UIKit

extension UILabel {
    
    // FIXME: 似乎有bug
    /// 快速创建label的方法
    ///
    /// - Parameters:
    ///   - text: text
    ///   - textColor:
    ///   - fontSize:
    ///   - alignment:
    ///   - lines: numberLines
    ///   - backColor: 背景颜色
    convenience init(text: String = "",
                     textColor: UIColor = UIColor.black,
                     fontSize: CGFloat = 14,
                     alignment: NSTextAlignment = NSTextAlignment.left,
                     lines: Int = 1) {
        self.init()
        
        self.text = text
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textAlignment = alignment
        self.numberOfLines = lines
    }
}

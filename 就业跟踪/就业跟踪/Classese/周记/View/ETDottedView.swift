//
//  ETDottedView.swift
//  添加周记
//
//  Created by student on 2018/6/14.
//  Copyright © 2018年 student. All rights reserved.
//

import UIKit

/// 虚线View
class ETDottedView: UIView {

    /// 虚线颜色
    var dottedColor: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let ctx = UIGraphicsGetCurrentContext()
 
        ctx?.move(to: CGPoint(x: 0, y: rect.height / 2))
        ctx?.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
        
        let arr: [CGFloat] = [10, 7]
        ctx?.setLineDash(phase: 0, lengths: arr)
        
        let color = dottedColor ?? UIColor.lightGray
        ctx?.setStrokeColor(color.cgColor)

        ctx?.strokePath()
    }
 

}

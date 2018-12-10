//
//  UIImage+Category.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/13.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit
// 30* 30
extension UIImage {
    /// 调整图片大小
    ///
    /// - Parameters:
    ///   - size: 要调整的图片大小
    ///   - isShowCornerRadius: 是否圆角
    /// - Returns: UIImage
    func adjustImageSize(size: CGSize, isShowCornerRadius: Bool = false) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        if isShowCornerRadius == true {
            let ctx = UIGraphicsGetCurrentContext()
            let centerPoint = CGPoint(x: size.width / 2, y: size.height / 2)
            ctx?.addArc(center: centerPoint, radius: size.width / 2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
            ctx?.clip()
        }
        
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return img
    }
    
    /// 让图片保持原本的模式，防止tabbar渲染图片
    ///
    /// - Returns: UIImage
    func originImage() -> UIImage {
        return withRenderingMode(.alwaysOriginal)
    }
    

    /// 根据颜色画一张纯色的背景图片出来
    ///
    /// - Parameter color:
    /// - Returns: 
    class func colorBackgroundImage(color: UIColor, size: CGSize = CGSize(width: 500, height: 500)) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        color.setFill()
        
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        path.fill()
        
        
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
}


//let linePath = UIBezierPath()
//let ctx = UIGraphicsGetCurrentContext()
//ctx?.setLineWidth(5)
//
//linePath.move(to: CGPoint(x: 0, y: size.height - 2))
//linePath.addLine(to: CGPoint(x: size.width, y: size.height))
//UIColor.black.setStroke()
//linePath.stroke()


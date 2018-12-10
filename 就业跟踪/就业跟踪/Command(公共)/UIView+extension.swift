//
//  UIView+extension.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/22.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

/// gradientLayey属性的key
private var gradientLayerKey = "gradientLayer"

extension UIView {
    
    /// 渐变layer
    var gradientLayer: CAGradientLayer {
        get {
            return objc_getAssociatedObject(self, &gradientLayerKey) as! CAGradientLayer
        }
        
        set {
            objc_setAssociatedObject(self, &gradientLayerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 给view添加渐变色背景
    func addGradientBackgroundColor() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.locations = [0, 1]
        gradientLayer.colors = [ETGradientBlueColor.cgColor, ETBlueColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = layer.cornerRadius
        
        layer.insertSublayer(gradientLayer, at: 0)

    }
}

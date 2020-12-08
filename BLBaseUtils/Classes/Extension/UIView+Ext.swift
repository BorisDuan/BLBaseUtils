//
//  UIView+Ext.swift
//  AiBeLove
//
//  Created by blyx on 2020/7/7.
//  Copyright © 2020 重庆彼恋有喜婚姻服务有限公司. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    public func addTapGesture(target: Any?, action: Selector?) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(tap)
    }
    
    
    
    public func setSignUpBackShadow() {
        
        superview?.layoutIfNeeded()
        
        self.layer.cornerRadius = 5
        // 阴影颜色
        self.layer.shadowColor = UIColor(hexString: "#1B1B1B").cgColor
        // 阴影偏移，默认(0, -3)
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        // 阴影透明度，默认0
        self.layer.shadowOpacity = 0.22;
        // 阴影半径，默认3
        self.layer.shadowRadius = 2.5;
        
        // 优化无离屏渲染
        let path = UIBezierPath(rect: bounds)
        layer.shadowPath = path.cgPath;
    }
    
    
    public func setBorders(radius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        
        self.layer.cornerRadius = radius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        
    }
    
    
    public func setCorners(radius: CGFloat) {
        
        superview?.layoutIfNeeded()
        
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath;
        self.layer.mask = maskLayer
        
    }
    
    
}







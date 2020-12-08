//
//  UIImage+Ext.swift
//  AiBeLove
//
//  Created by blyx on 2020/7/25.
//  Copyright © 2020 重庆彼恋有喜婚姻服务有限公司. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    public func fromColor(_ color: UIColor, rect: CGRect) -> UIImage {
//        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

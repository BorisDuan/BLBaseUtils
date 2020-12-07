//
//  String+Ext.swift
//  AiBeLove
//
//  Created by blyx on 2020/7/15.
//  Copyright © 2020 重庆彼恋有喜婚姻服务有限公司. All rights reserved.
//

import Foundation

extension String {
    
    var isBlank: Bool {
      return allSatisfy({ $0.isWhitespace })
    }
    
    func isPhoneNumber () -> Bool {
        let pattern2 = "^1[3|4|5|6|7|8|9][0-9]{9}$"
        if NSPredicate(format: "SELF MATCHES %@", pattern2).evaluate(with: self) {
            return true
            
        }
        return false
    }


    
}

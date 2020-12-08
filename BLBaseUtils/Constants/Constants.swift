//
//  Constants.swift
//  AiBeLove
//
//  Created by 段振伟 on 2020/6/30.
//  Copyright © 2020 重庆彼恋有喜婚姻服务有限公司. All rights reserved.
//

import Foundation
import UIKit



public let KDateFormatterYMD:DateFormatter =  {
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd"
    return df
}()

public let KDateFormatterMD:DateFormatter =  {
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd"
    return df
}()

public let KDateFormatterYMDHM:DateFormatter =  {
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd HH:mm"
    return df
}()
    

public let KMainWidth = UIScreen.main.bounds.size.width
public let KMainHeight = UIScreen.main.bounds.size.height

public let isIPhoneSE: Bool = (KMainHeight==568)

public let KHeightScale: CGFloat = KMainHeight/667.0
public let KWidthScale: CGFloat = KMainWidth/375.0
//适配iPhoneX
//获取状态栏的高度，全面屏手机的状态栏高度为44pt，非全面屏手机的状态栏高度为20pt

//状态栏高度
public let KStatusBarHeight = CGFloat(UIApplication.shared.statusBarFrame.height)

//导航栏44高度
public let KNaviBarHeight: CGFloat = 44.0

//导航栏44高度
public let KStatusNaviBarHeight: CGFloat = (KStatusBarHeight + 44.0)

//tabbar高度
public let KTabBarHeight: CGFloat = (KStatusBarHeight>20.0 ? 83.0 : 49.0)

//顶部的安全距离
public let KTopSafeAreaHeight: CGFloat = (KStatusBarHeight - 20.0)

//底部的安全距离
public let KBottomSafeAreaHeight: CGFloat = (KTabBarHeight - 49.0)

public let KNotificationCenter = NotificationCenter.default

public func BLEnumFromInt<T: CaseIterable>(_ index: Int, type: T.Type) -> T? {
    if index < 0 || index > T.allCases.count-1 {
        return nil
    } else {
        return T.allCases[index as! T.AllCases.Index]
        
    }
}



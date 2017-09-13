//
//  NSObjectExtension.swift
//  EventManager
//
//  Created by 白井　誠 on 2017/09/11.
//  Copyright © 2017年 Sample. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// クラス名
    class var className: String { return String(describing: self) }
    
    /// クラス名
    var className: String { return type(of: self).className }
}

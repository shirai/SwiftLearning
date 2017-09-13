//
//  DateExtension.swift
//  EventManager
//
//  Created by 白井　誠 on 2017/09/11.
//  Copyright © 2017年 Sample. All rights reserved.
//

import Foundation

/// フォーマット
internal enum DateFormat: String {
    case H時
}

extension Date {
    
    /// 指定したフォーマットの文字列を返却する
    ///
    /// - Parameter format: フォーマット
    /// - Returns: フォーマットに合わせた文字列
    func string(with format: DateFormat) -> String {
        
        let formatter = DateFormatter()
        // 日本時間に合わせたformatterを生成する
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "ja_JP")
        
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}

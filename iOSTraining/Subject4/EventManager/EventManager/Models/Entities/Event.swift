//
//  Event.swift
//  EventManager
//
//  Created by 白井　誠 on 2017/09/11.
//  Copyright © 2017年 Sample. All rights reserved.
//

import Foundation

/// イベント情報
internal struct Event {
    
    // MARK: Properties
    
    /// イベント名
    let name: String
    /// 場所
    let place: String
    /// 開始時間
    let startTime: Date
    /// 参加者リスト
    var participants: [Participant]
    
    // MARK: Initializers
    
    /// plistから取得したデータを基にイベント情報を生成する
    ///
    /// - Parameter dictionary: EventList.plistのrootArrayの子item
    init(dictionary: [String : Any]) {
        
        name = dictionary["name"] as! String
        place = dictionary["place"] as! String
        startTime = dictionary["startTime"] as! Date
        participants = (dictionary["participants"] as! [[String : Any]]).map { Participant(dictionary: $0) }
    }
}

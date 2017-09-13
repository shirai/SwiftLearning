//
//  Participant.swift
//  EventManager
//
//  Created by 白井　誠 on 2017/09/11.
//  Copyright © 2017年 Sample. All rights reserved.
//

/// 参加者
internal struct Participant {
    
    // MARK: Properties
    
    /// 名前
    let name: String
    
    // MARK: Initializers
    
    /// 指定イニシャライザー的な何か
    ///
    /// - Parameter name: 名前
    init(name: String) {
        self.name = name
    }
    
    /// plistから取得したデータを基にイベント情報を生成する
    ///
    /// - Parameter dictionary: EventList.plistのparticipantsの子item
    /// - Note: plistに必要な項目が揃っていない場合はfatalErrorになります
    init(dictionary: [String : Any]) {
        name = dictionary["name"] as! String
    }
}

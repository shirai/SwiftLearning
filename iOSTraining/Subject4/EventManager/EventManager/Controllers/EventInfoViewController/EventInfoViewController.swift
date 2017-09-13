//
//  EventInfoViewController.swift
//  EventManager
//
//  Created by 白井　誠 on 2017/09/11.
//  Copyright © 2017年 Sample. All rights reserved.
//

import UIKit

/// イベント詳細画面
internal final class EventInfoViewController: UIViewController {

    // MARK: Properties
    
    /// イベント情報
    var event: Event! = nil {
        didSet {
            updateViews()
        }
    }
    
    // MARK: IBOutlets
    
    /// 場所ラベル
    @IBOutlet private weak var placeLabel: UILabel!
    /// 開始時間ラベル
    @IBOutlet private weak var startTimeLabel: UILabel!
    /// 現在参加人数ラベル
    @IBOutlet private weak var participantsCountLabel: UILabel!
    /// 参加者氏名ラベル
    @IBOutlet private weak var participantsLabel: UILabel!
    
    // MARK: IBActions
    
    @IBAction private func onTapJoinButton(_ sender: UIButton) {
        
        let vc: ParticipantEventViewController = ParticipantEventViewController.instantiateFromStoryboard()
        vc.delegate = self
        
        // navigationBarを表示するためにNavigationControllerを生成しpresentする
        let nc = UINavigationController(rootViewController: vc)
        navigationController?.present(nc, animated: true, completion: nil)
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Private Functions
    
    /// イベント情報を基にViewを更新する
    private func updateViews() {
        
        placeLabel.text = "場所：\(event.place)"
        startTimeLabel.text = "開始時間：\(event.startTime.string(with: .H時))"
        participantsCountLabel.text = "現在参加人数：\(event.participants.count)人"
        participantsLabel.text = "参加者氏名：\(event.participants.map { $0.name }.joined(separator: "、"))"
    }
}

// MARK: ParticipantEventViewDelegate

extension EventInfoViewController: ParticipantEventViewDelegate {
    
    func didEditComplete(participant: Participant) {
        
        event.participants.append(participant)
    }
}

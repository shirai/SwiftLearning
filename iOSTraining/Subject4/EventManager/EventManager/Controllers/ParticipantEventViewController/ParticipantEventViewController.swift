//
//  ParticipantEventViewController.swift
//  EventManager
//
//  Created by 白井　誠 on 2017/09/11.
//  Copyright © 2017年 Sample. All rights reserved.
//

import UIKit

/// 参加者編集画面デリゲート
internal protocol ParticipantEventViewDelegate: class {
    
    /// 編集完了時処理
    ///
    /// - Parameter participant: 編集した参加者情報
    func didEditComplete(participant: Participant)
}

/// 参加者編集画面
internal final class ParticipantEventViewController: UIViewController {
    
    // MARK: Properties
    
    weak var delegate: ParticipantEventViewDelegate! = nil
    
    // MARK: IBOutlets
    
    /// 名前入力テキストフィールド
    @IBOutlet weak var nameTextField: UITextField!
    
    // MARK: IBActions
    
    /// 完了ボタンタップイベント
    ///
    /// - Parameter sender: 完了ボタン
    @IBAction func onTapComplete(_ sender: Any) {
        
        guard let name = nameTextField.text else { return }
        if name.isEmpty { return }
        
        delegate.didEditComplete(participant: Participant(name: name))
        dismiss(animated: true, completion: nil)
    }
    
    /// キャンセルボタンタップイベント
    ///
    /// - Parameter sender: キャンセルボタン
    @IBAction func onTapCancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editingChangedName(_ sender: UITextField) {
        
        let hasName = !sender.text!.isEmpty
        navigationItem.rightBarButtonItem?.isEnabled = hasName
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

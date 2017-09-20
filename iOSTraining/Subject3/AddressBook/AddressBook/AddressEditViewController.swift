//
//  AddressEditViewController.swift
//  AddressBook
//
//  Created by 白井　誠 on 2017/08/23.
//  Copyright © 2017年 Makoto Shirai. All rights reserved.
//

import UIKit

/// 連絡先詳細画面デリゲート
protocol AddressEditViewControllerDelegate: class {
    
    /// 連絡先情報編集完了時処理
    ///
    /// - Parameter address: 編集後の連絡先情報
    func didChangeAddress(_ address: Address)
}

/// 連絡先編集画面
class AddressEditViewController: UIViewController {
    
    // MARK: enumerations
    
    /// バリデーション結果
    private enum ValidationResult {
        /// 成功
        /// - address: チェック後のアドレス情報
        case successful(address: Address)
        /// 失敗
        /// - errors: エラー一覧
        case failed(errors: Set<ValidationError>)
        
        /// バリデーションエラー
        enum ValidationError: CustomStringConvertible {
            /// メールアドレス未入力
            case mailAddressEmpty
            /// モバイル番号未入力
            case phoneNumberEmpty
            
            var description: String {
                switch self {
                case .mailAddressEmpty:
                    return "メールアドレス"
                case .phoneNumberEmpty:
                    return "モバイル番号"
                }
            }
        }
    }
    
    // MARK: Properties
    
    /// 連絡先情報
    var address: Address!
    /// 編集完了時処理通知先
    weak var delegate: AddressEditViewControllerDelegate!
    
    // MARK: IBOutlets
    
    /// メールアドレステキストフィールド
    @IBOutlet weak var mailAddressTextField: UITextField!
    /// モバイル番号テキストフィールド
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    // MARK: IBActions
    
    /// 完了ボタンタップ時アクション
    ///
    /// - Parameter sender: 完了ボタン
    @IBAction func onTapComplete(_ sender: UIBarButtonItem) {
        
        switch validateInputAddress() {
        case .successful(let address):
            delegate.didChangeAddress(address)
            dismiss(animated: true, completion: nil)
        case .failed(let errors):
            let errorMessage = errors.reduce("以下の項目は必須です。") { $0 + "\n・\($1)" }
            let alert = UIAlertController(title: "必須項目を入力してください",
                                          message: errorMessage,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "閉じる", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    /// キャンセルボタンタップ時アクション
    ///
    /// - Parameter sender: キャンセルボタン
    @IBAction func onTapCancel(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mailAddressTextField.text = address.mailAddress
        phoneNumberTextField.text = address.phoneNumber
    }
    
    // MARK: Private Functions
    
    /// 入力された連絡先情報のバリデーションチェックを行う
    ///
    /// - Returns: バリデーション結果
    private func validateInputAddress() -> ValidationResult {
        
        var errors = Set<ValidationResult.ValidationError>()
        
        // メールアドレスチェック
        if mailAddressTextField.text?.isEmpty ?? false {
            errors.update(with: .mailAddressEmpty)
        }
        // モバイル番号チェック
        if phoneNumberTextField.text?.isEmpty ?? false {
            errors.update(with: .phoneNumberEmpty)
        }
        
        if errors.isEmpty {
            return .successful(address: Address(name: address.name,
                                                mailAddress: mailAddressTextField.text!,
                                                phoneNumber: phoneNumberTextField.text!))
        } else {
            return .failed(errors: errors)
        }
    }
}

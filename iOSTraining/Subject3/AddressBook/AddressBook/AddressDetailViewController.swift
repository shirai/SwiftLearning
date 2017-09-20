//
//  AddressDetailViewController.swift
//  AddressBook
//
//  Created by 白井　誠 on 2017/08/23.
//  Copyright © 2017年 Makoto Shirai. All rights reserved.
//

import UIKit

/// 連絡先詳細画面
class AddressDetailViewController: UIViewController {
    
    // MARK: Properties
    
    /// 連絡先情報
    var address: Address!
    
    // MARK: IBOutlets
    
    /// メールアドレスラベル
    @IBOutlet weak var mailAddressLabel: UILabel!
    /// 電話番号ラベル
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    // MARK: Private Functions
    
    /// 画面上の各viewを更新する
    fileprivate func updateViews() {
        
        mailAddressLabel.text = address.mailAddress
        phoneNumberLabel.text = address.phoneNumber
    }
    
    // MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // identifierはIBで設定済み
        switch segue.identifier {
        case "showEdit"?:
            guard
                let nc = segue.destination as? UINavigationController,
                let vc = nc.topViewController as? AddressEditViewController
                else {
                    fatalError()
            }
            vc.address = address
            vc.delegate = self
        default:
            break
        }
    }
}

extension AddressDetailViewController: AddressEditViewControllerDelegate {
    
    func didChangeAddress(_ address: Address) {
        
        self.address = address
        updateViews()
    }
}

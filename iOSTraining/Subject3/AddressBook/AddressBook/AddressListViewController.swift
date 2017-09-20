//
//  AddressListViewController.swift
//  AddressBook
//
//  Created by 白井　誠 on 2017/08/23.
//  Copyright © 2017年 Makoto Shirai. All rights reserved.
//

import UIKit

/// 連絡先一覧画面
class AddressListViewController: UITableViewController {
    
    // MARK: Properties
    
    /// 連絡先一覧
    let addressList = AddressListViewController.loadAddressListFromPlist()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Public Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return addressList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // identifierはIBで設定済み
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressListCell", for: indexPath)
        cell.textLabel?.text = addressList[indexPath.row].name
        return cell
    }
    
    // MARK: Private Functions
    
    /// plistから連絡先一覧を取得する
    ///
    /// - Returns: 連絡先一覧
    private static func loadAddressListFromPlist() -> [Address] {
        
        // バンドルされているEventList.plistからイベント一覧を取得する
        let fileURL = Bundle.main.url(forResource: "AddressList", withExtension: "plist")!
        let data = try! Data(contentsOf: fileURL)
        let plist = try! PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [[String : Any]]
        return plist.map {
            Address(name: $0["name"] as! String,
                    mailAddress: $0["mailAddress"] as! String,
                    phoneNumber: $0["phoneNumber"] as! String
            )
        }
    }
    
    // MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // identifierはIBで設定済み
        switch segue.identifier {
        case "showDetail"?:
            guard
                let indexPath = tableView.indexPathForSelectedRow,
                let vc = segue.destination as? AddressDetailViewController
                else {
                    fatalError()
            }
            vc.address = addressList[indexPath.row]
        default:
            break
        }
    }
}

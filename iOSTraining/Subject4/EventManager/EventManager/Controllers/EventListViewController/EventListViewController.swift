//
//  EventListViewController.swift
//  EventManager
//
//  Created by 白井　誠 on 2017/09/11.
//  Copyright © 2017年 Sample. All rights reserved.
//

import UIKit

/// イベント一覧画面
internal final class EventListViewController: UITableViewController {

    // MARK: Properties
    
    /// イベント一覧
    private let eventList: [Event] = {
        
        // バンドルされているEventList.plistからイベント一覧を取得する
        let fileURL = Bundle.main.url(forResource: "EventList", withExtension: "plist")!
        let data = try! Data(contentsOf: fileURL)
        let plist = try! PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [[String : Any]]
        return plist.map { Event(dictionary: $0) }
    }()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = eventList[indexPath.row].name

        return cell
    }

    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc: EventInfoViewController = EventInfoViewController.instantiateFromStoryboard()
        vc.event = eventList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

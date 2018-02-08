//
//  DandoriListViewController.swift
//  Dandori
//
//  Created by 白井　誠 on 2017/09/06.
//  Copyright © 2017年 Sample. All rights reserved.
//

import UIKit

class DandoriListCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    
    // MARK: - IBActions
    @IBAction func didTappedCheckButton(_ sender: UIButton) {
    }
    @IBAction func didChangedGenderSegment(_ sender: UISegmentedControl) {
    }
}

class DandoriListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
}

extension DandoriListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "分類Aのダンドリ　　　　　　　　　　　　　　 3"
        case 1:
            return "分類Bのダンドリ　　　　　　　　　　　　　　10"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dandoriCell", for: indexPath) as! DandoriListCell
        
        switch indexPath.section {
        case 0:
            cell.titleLabel.text = "A-\(indexPath.row + 1)のダンドリ"
        case 1:
            cell.titleLabel.text = "B-\(indexPath.row + 1)のダンドリ"
        default:
            break
        }
        cell.dateLabel.text = "2017/09/1\(indexPath.row + 3)"
        if indexPath.row > 1 {
            cell.genderSegment.selectedSegmentIndex = 1
        } else {
            cell.checkButton.titleLabel?.text = "■"
        }
        return cell
    }
}

extension DandoriListViewController: UITableViewDelegate {
    
}

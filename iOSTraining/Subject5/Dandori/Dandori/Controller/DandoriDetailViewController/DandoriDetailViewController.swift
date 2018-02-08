//
//  DandoriDetailViewController.swift
//  Dandori
//
//  Created by 白井　誠 on 2017/09/06.
//  Copyright © 2017年 Sample. All rights reserved.
//

import UIKit

class DandoriDetailViewController: UIViewController {
    
    @IBOutlet weak var changeDateButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        changeDateButton.backgroundColor = UIApplication.shared.keyWindow?.tintColor
    }
}

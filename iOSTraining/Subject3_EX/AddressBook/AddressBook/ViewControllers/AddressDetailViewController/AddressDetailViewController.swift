//
//  AddressDetailViewController.swift
//  AddressBook
//
//  Created by 白井　誠 on 2017/09/20.
//  Copyright © 2017年 Sample. All rights reserved.
//

import UIKit

class AddressDetailViewController: UIViewController {
    
    // MARK: Properties
    
    var address: Address? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    // MARK: IBOutlets
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!

    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    // MARK: Private Functions
    
    private func configureView() {
        
        // Update the user interface for the detail item.
        guard
            let address = address,
            let label = detailDescriptionLabel else { return }
        
        label.text = address.name
    }
}

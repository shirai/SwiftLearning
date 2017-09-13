//
//  UIViewControllerExtension.swift
//  EventManager
//
//  Created by 白井　誠 on 2017/09/11.
//  Copyright © 2017年 Sample. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// StoryboardからViewControllerをインスタンス化する
    ///
    /// - Returns: StoryboardのinitialVCをインスタンス化して返却する
    /// - Note: VC名とStorybaord名は同じ名前にしてください。
    static func instantiateFromStoryboard<ViewController: UIViewController>() -> ViewController {
        
        let storyboard = UIStoryboard(name: ViewController.className, bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! ViewController
        
        // FIXME: viewDidLoad前にOutletにアクセスしようとした場合、Outletがnilになるので一度viewを取得。もっとスマートに書きたい
        let _ = vc.view
        
        return vc
    }
}

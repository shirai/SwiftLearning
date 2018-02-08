//: Playground - noun: a place where people can play

import UIKit

/* リソースマネージャ */
class ResourceManager {
    // リソースを獲得してリソースIDを返す。
    class func getResource(filePath: String) -> Int {
        var resourceId: Int
        resourceId = 1 // リソースを獲得する処理
        return resourceId;
    }
    class func releaseResource(resourceId: Int) {
        // リソースを解放する処理
    }
}

/* クライアントクラス　*/
class Client {
    var resourceId: Int
    // イニシャライザ
    init(filePath: String) {
        resourceId = ResourceManager.getResource(filePath: filePath)
        //リソースマネージャからリソースを取得
    }
    // デイニシャライザ
    deinit {
        ResourceManager.releaseResource(resourceId: resourceId)
    }
}
//
//  PropertyListManager.swift
//  AddressBook
//
//  Created by 白井　誠 on 2017/09/20.
//  Copyright © 2017年 Sample. All rights reserved.
//

import Foundation

protocol PlistValueType {}

extension String: PlistValueType {}
extension URL: PlistValueType {}
extension NSNumber: PlistValueType {}
extension Int: PlistValueType {}
extension Float: PlistValueType {}
extension Double: PlistValueType {}
extension Bool: PlistValueType {}
extension Date: PlistValueType {}
extension Data: PlistValueType {}
extension Array: PlistValueType {}
extension Dictionary: PlistValueType {}

/// このクラスを拡張し、plistキーを静的定数として追加する
class Keys {}

final class Key<ValueType: PlistValueType>: Keys {
    
    public let key: String
    
    internal var separatedKeys: [String] {
        return key.components(separatedBy: ".")
    }
    
    public init(_ key: String) {
        self.key = key
    }
    
}

/// プロパティリスト
struct PropertyList {
    
    /// plistから取得したdictionary
    private let dictionary: NSDictionary
    
    public init?(plistPath: String) {
        
        guard let plist = NSDictionary(contentsOfFile: plistPath) else {
            assertionFailure("could not read plist file.")
            return nil
        }
        dictionary = plist
    }
    
    /// plistから値を取得する
    ///
    /// - Parameter key: plistキー
    /// - Returns: plistキーに相当する値
    func get<T>(_ key: Key<T>) -> T? {
        var object: AnyObject = dictionary
        
        // keyが階層となっている場合は、階層を潜ってdictionaryを取得する
        key.separatedKeys.enumerated().forEach { idx, separatedKey in
            if let index = Int(separatedKey) {
                let array = object as! Array<AnyObject>
                object = array[index]
            } else {
                let dictionary = object as! NSDictionary
                object = dictionary[separatedKey]! as AnyObject
            }
        }
        
        let optionalValue: T?
        
        switch T.self {
        case is Int.Type: optionalValue = object as? T
        case is Float.Type: optionalValue = object.floatValue as? T
        case is Double.Type: optionalValue = object.doubleValue as? T
        case is URL.Type: optionalValue = URL(string: (object as? String) ?? "") as? T
        default: optionalValue = object as? T
        }
        
        guard let value = optionalValue else {
            assertionFailure("Could not cast value of type \(type(of: object)) to \(T.self)")
            return nil
        }
        
        return value
    }
}

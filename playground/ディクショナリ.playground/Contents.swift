//: Playground - noun: a place where people can play

import UIKit

/*ディクショナリは、文字列や数値をキーにして値を格納したり参照できる型です*/

/*
 *
 *宣言
 var <辞書データ名> : Dictionary <<キーの型>,<値の型>> =[<キー>:<値>,<キー>:<値>,<キー>:<値>]
 *
 */
let family: Dictionary<String, String> = ["父": "ひろし", "母": "みさえ", "長男":"しんのすけ", "長女":"ひまわり"]
if let 主人公1 = family["長男"] {
    print(主人公1)
}
//var <辞書データ名> : [<キーの型>:<値の型>] = [<キー>:<値>,<キー>:<値>]
var family2: [String: String] = ["父": "波平", "母": "フネ", "長女":"サザエ", "長男":"カツオ","次女":"ワカメ"]
if let 主人公2 = family2["長女"] {
    print(主人公2)
}

//初期値を与える場合は要素から方が推測される
var family3 = ["父": "ひろし", "母": "すみれ", "長女":"さきこ", "次女":"ももこ"]
if let 主人公3 = family3["次女"] {
    print(主人公3)
}

// 空のディクショナリの宣言（キーがString型、値がString型のディクショナリ）
var party1: Dictionary<String, String> = [:]
var party2: [String: String] = [:]
var party3 = Dictionary<String, String>()
var party4 = [String: String]()

/*
 *
 *要素の追加
 *
 */
family2 ["婿"] = "マスオ"
if let A = family2["婿"] {
    print(A)
}

/*
 *
 *要素の変更
 *
 */
family3 ["次女"] = "まる子"
if let B = family3["次女"] {
    print(B)
}
//ディクショナリを定数として宣言した場合は、値の変更や追加はできない。
//family1 ["ペット"] = "シロ"

//updateValueメソッドを使って、値を更新し、更新前の値を取り出す
let old = family3.updateValue("咲子", forKey:"長女")
print(old!)

//ディクショナリの要素数を出力する
print("野原家は、\(family.count)人家族")

/*
 *
 *要素の削除
 *
 */
print("磯野家は、\(family2.count)人家族")
family2 ["婿"] = nil
print("磯野家は、\(family2.count)人家族")

//removeValueForKeyメソッドを使って、要素を削除し、削除前の値を取り出す
if let oldValue = family3.removeValue(forKey: "長女"){
    print(oldValue)
}

//初期化
family3 = [:]
print(family3.count)

/*
 *
 *イテレーション
 *
 */
//for文を使った繰り返し
for (status, name) in family {
    print("\(status): 野原\(name)")
}

// キーのみ出力
for key in family.keys {
    print("構成員:\(key)")
}
// 値のみ出力
for value in family.values {
    print("家族:\(value)")
}


/*
 *
 *ディクショナリのコピー
 *
 */
var newFamily = family
newFamily["ペット"] = "シロ"
print(newFamily)

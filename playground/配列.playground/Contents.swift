//: Playground - noun: a place where people can play

import UIKit

/*
 *
 *宣言
 *
 */
 //型を指定して配列を作成
let party: [String] = ["勇者", "戦士", "魔法使い", "僧侶"]
print(party[2]) //インデックスで要素を参照する。
print("パーティの人数は、\(party.count)人です。") //要素数をcountプロパティで取得する。

//初期値で型を推測して配列を作成
var お弁当 = ["おにぎり", "玉子焼き", "ミニトマト", "アスパラ"]

//初期値に同じ数字を入れて配列を作成。
let point = Array(repeating: 100, count: 4) //repeatedValueではなくrepeating
print(point)

//空の配列を作成する。(データ型の指定が必須)
var box : [UInt] = []
var box2 = [UInt] ()
var box3 : Array<UInt> = []
//配列が空かどうかをisEmptyプロパティで調べる
if box.isEmpty {
    print("配列は空です。")
}

//初期化の時に異なる型の要素を含める。Any又はAnyObject
var a: Array<Any> = [100, 123.4, "文字列"] // 異なる型の要素
print(50 + (a[0] as! Int)) // 計算等する場合はキャスト（型変換）が必要(なぜかasの後に!が必要)

//関数を配列要素にする。
let add = { (a: Double, b: Double) -> Double in return a + b } //二つDouble型の値を受け取ったら、足し算して返す
let sub = { (a: Double, b: Double) -> Double in return a - b }
let mul = { (a: Double, b: Double) -> Double in return a * b }
let div = { (a: Double, b: Double) -> Double in return a / b }
var ope: [(Double, Double) -> Double] //[(関数の引数) -> 関数の戻り値]

ope = [add, sub, mul, div]

ope[2](10, 20)

/*
 *
 *要素の追加
 *
 */
お弁当.append("タコさんウインナー")
お弁当 += ["ブロッコリー","りんご"]
print(お弁当)
//宣言時の値と異なる型の値を混在はできない
//お弁当.append(100)  //エラーになる
//定数の配列は、要素を変更したり追加することはできない。
//party.append("盗賊")   // エラーになる

//要素を指定位置に挿入する
//お弁当.insert("キウイ", atIndex : 2)
お弁当.insert("キウイ", at : 2)
print(お弁当)

/*
 *
 *要素の変更
 *
 */
お弁当[0] = "おむすび"
print(お弁当)
//お弁当[10] = "ふりかけ"// インデックス範囲外を指定すると実行時エラーになる
//お弁当[0] = 10  // 配列の宣言時と異なる値を代入するとコンパイル時エラーになる

// インデックス1の値（インデックス2は含めない）を変更
お弁当[1..<2] = ["ゆで卵", "肉巻き"]
print(お弁当)
// インデックス0の値（インデックス2は含めない）を変更
お弁当[0...2] = ["サンドイッチ", "オムレツ"]
print(お弁当)

/*
 *
 *要素の削除
 *
 */
//指定したインデックスの要素を削除
お弁当.remove(at: 2)
print(お弁当)
//配列の最後の要素を削除
お弁当.removeLast()
print(お弁当)
//初期化
お弁当 = []
print(お弁当)

/*
 *
 *イティレーション
 *
 */
//for文を使って繰り返し処理
var book = ["こころ", "山椒魚", "檸檬", "細雪"]
for chara in book{
    print(chara)
}
//インデックスも使いたい場合
//for (index, chara) in enumerate(party) {
for(index, chara) in book.enumerated(){
     print("\(index + 1): \(chara)")
}

/*
 *
 *配列のコピー
 *
 */
var book2 = book
book2[1] = "蟹工船"
print(book)
print(book2)

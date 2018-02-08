//: Playground - noun: a place where people can play

import UIKit

/*タプルは、複数のデータをセットにして扱い、その並びを使って要素を扱います。
 配列と似ていますが、違う点はm異なるデータ型を並べて扱うことができるところです。
 「このデータと、このデータがセットですよ」と意味づけをして、データの受け渡しなどに使います。
 そのため、後から新しく要素を追加したり削除したりすることはできません*/

let item = ("ジュース", 100, 0.08, 108) //String型とInt型の混在
print("商品名=\(item.0), 税抜き価格=\(item.1)円, 消費税=\(item.2 * 100)%, 税込み価格=\(item.3)円")
//タプル名.ゼロから始まる順番名

let (name,price,tax,priceWithTax) = ("ジュース", 100, 0.08, 108)
print("商品名=\(name), 税抜き価格=\(price)円, 消費税=\(tax * 100)%, 税込み価格=\(priceWithTax)円")
//タプルの各要素を別々の変数に受け取る

let item2 = (name:"ジュース", price:100, tax:0.08, priceWithTax:108)
print("商品名=\(item2.name), 税抜き価格=\(item2.price)円, 消費税=\(item2.tax * 100)%, 税込み価格=\(item2.priceWithTax)円")
//タプルにラベルをつけて参照
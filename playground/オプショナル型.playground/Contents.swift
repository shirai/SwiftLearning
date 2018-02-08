//: Playground - noun: a place where people can play

import UIKit

/*オプショナル型とは、変数の型がもつ通常の値に加えて、空の（値が無い）状態を保持できる変数です。空の状態はnilで表現します。*/

/*
 *
 *宣言
 変数の宣言時に、型の後ろに「?」をつけて宣言
 *
 */
var name: String?
//name = nil //nilを入れなくても最初に入っている

name = "Saki"
print(name) //"?"のオプショナル型の変数は出力したときにOptionalという記述が含まれる
name = "Saki"
print(name!) // 変数名の後ろに!をつけてアンラップ

// オプショナル型でない変数にはnilを代入できない。
//var name1: String
//name1 = nil  // エラーになる。

/*
 *
 *オプショナルバインディング
 
 値が空（nil）の場合はfalse、それ以外はtrue
 アンラップをする場合には、必ずラッピングの中身が存在する(=nilではない)ことが保証されていなければいけません。
 nilかどうかわからない場合は後述するオプショナルチェイニングかオプショナルバインディングを使いましょう。
 *
 */
var price: Int? = 100
if let p = price {
    print("価格:\(p)円")
}else{
    print("価格:未定")
}
price = nil
if let p = price {
    print("価格:\(p)円")
}else{
    print("価格:未定")
}

/*
 *
 *アンラップ
 オプショナル型を計算で使用したり、通常の型を受け取る関数の引数に渡したりする場合は、値が空でないことを明示するために、アンラップする必要があります。アンラップはラップ（包装）の反対で、オプションという包装紙に包まれた変数の包装を解くイメージです。
 *アンラップするには、オプショナル型の変数名の後ろに「!」をつけます。
 *
 */
var diameter: Double?
diameter = 4
print("円の周りの長さは\(Double(Double(diameter!) * 3.14))センチです。")// 変数名の後ろに!をつけてアンラップ

var diameter2: Int?
diameter2 = 4
print("円の周りの長さは\(Int(Double(diameter2!) * 3.14))センチです。")// 変数名の後ろに!をつけてアンラップ
/*3.14はDouble型。自動変換されないので、Double型*Double型しかできない。（Int*Double->エラー）一番外側で計算結果の型を指定する。*/

//中身が空（nil）のオプショナル型の変数をアンラップすると実行時エラーが発生
//diameter = nil
//print("円の直径は\(Double(Double(diameter!)*3.14))㎠です。")

 //非オプショナル型を受けとるには関数の呼び出し側でアンラップが必要
func calculateTax(p: Int) -> Int { //func <関数>(<引数名>:<型>){<処理>}
    return Int(Double(p) * 1.08)
}
var price2: Int?
price2 = 300
let priceWithTax = calculateTax(p:price2!)//変数名の後ろに!をつけてアンラップ
print(priceWithTax)


//if文を使うと、値が空かどうかの判定とアンラップされた別変数への代入を同時に行うことができる。
diameter = 4

if let unwrappedDiameter = diameter{
    // unwrappedPriceはアンラップされているので後ろに!は不要
    print("円の周りの長さは \(unwrappedDiameter*3.14) センチです。")
}


diameter = nil
if let unwrappedDiameter = diameter{
    // unwrappedPriceはアンラップされているので後ろに!は不要
    print("円の周りの長さは \(unwrappedDiameter*3.14) センチです。")
}else{
    print("円の直径がわかりません。")
}
//定数でも変数でも同様に書ける

//配列やディクショナリも同様にオプショナル型として宣言できる
var party: Array<String>?
party = ["戦士", "魔法使い"]
party!.append("nil") // 変数名の後ろに!をつけてアンラップ
party!.append("僧侶") // 変数名の後ろに!をつけてアンラップ
print(party)

/*
 *
 *暗黙的なオプショナル型
 宣言時に?ではなく!をつけて宣言
 暗黙的なオプショナル型は、空値（nil）をとり得るという意味では、上で説明したオプショナル型と同じですが、使用時にアンラップする必要がありません。
 アンラップの必要がないので、初期値がnilでも使用時までには必ず値が入っていると想定されるケースでは、暗黙的なオプショナル型の方が便利です。
 但し、アンラップが必要な状況で、暗黙的なオプショナル型を空のまま使用すると実行時エラーが発生します。
 *
 */
var うまい棒: Double!
うまい棒 = 10
print("税込み価格は\(Int(うまい棒 * 1.08))円")   // 変数名の後ろに!をつける必要がない
//うまい棒 = nil
//print("税込み価格は\(Int(うまい棒 * 1.08))円")   // エラー

/*暗黙的なオプショナル型の宣言に使用する!と、アンラップに使用する!を混同しないようにしてください。同じ記号が使われていますが意味は異なります。*/

//暗黙的なオプショナル型をif文の中で条件として使用
var ガリガリ君: Double!
ガリガリ君 = 60
if let unwrappedPrice = ガリガリ君 {
    print("税込み価格は\(Int(unwrappedPrice * 1.08))円")
} else {
    print("価格は未定")
}


/*
 *
 *nil結合演算子
 ??という演算子を使うと、オプショナル型がnilでなければその値を、nilの場合は指定した値を与えることができる。
 *
 */
var a: Int?
let b = a ?? 10 //aはnilなので、10が代入される
let c = b ?? 20 //bはnilではないので、20が代入される

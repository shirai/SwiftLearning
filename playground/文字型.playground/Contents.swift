//: Playground - noun: a place where people can play

import UIKit

let name: String
var str = "Hello, playground"
var number = String(123)

/*
 *
 *特殊文字
 *
 */
var ヌル文字 = "\0"
var バックスラッシュ = "\\"
var 水平タブ = "\t"
var ラインフィード = "\n"
var 改行 = "\r"
var ダブルクォート = "\""
var シングルクォート = "\'"
var ケース：1バイトのユニコードスカラ値 = "\u{40}"
var ケース：2バイトのユニコードスカラ値 = "\u{2665}"
//var ケース：4バイトのユニコードスカラ値 = "\u{F0A9B8BD}"
var 挨拶 = "こんにちは"

print("\(挨拶)\(ラインフィード)", terminator: "")
print("\(挨拶)\(改行)", terminator: "")
print("\(挨拶)", terminator: "")


/*
 *
 *文字列の操作
 *
 */
var name1 = "" //空文字
var name2 = String() //空文字
if name1.isEmpty{        //空文字かどうかの判定「isEmpty」
print("すっからかん")
}

var text = "メロンパン"
print(text.characters.count) // 文字列の長さを調べる[characters.count]
//「countElements」 ではない。

let prefix = "課題が"
let weather = "全然"
let suffix = "進まない"
var message = prefix + weather  // 文字列の連結
message += suffix               // 文字列の連結

/*
 *
 *文字列補完
 *
 */
var storey = 35
var  massage2 = "私の席は" + String(storey) + "階にあります" //Int型のstoreyをString型に変換して連結
print(massage2)
print("私の席は\(storey)階にあります。") //文字列中に、\( と ) で囲んで変数の値を含めることができる。

var hello: String = "Hello"
let mark: Character = "!"
print(hello + String(mark))//StringとCharacter同士も+演算子でそのまま連結することはできないので変換が必要
hello.append(mark) //但し、appendメソッドで連結することは可能
print(hello)

/*
 *
 *比較
 *
 */
let a = "A"
let b = "B"
if a == b {
    print("同じ")
} else if a < b {
    print("\(a)より\(b)の方が大きい")
} else {
    print("\(b)より\(a)の方が大きい")
} //文字列の比較には数値の場合と同様、==、<、<=、>、>= が使用できる

let d = "醤油ラーメン"
let e = "みそラーメン"
let f = "味噌汁"
print(d.hasPrefix("みそ"))
print(e.hasPrefix("みそ"))
print(f.hasPrefix("みそ"))
print(d.hasSuffix("ラーメン"))
print(e.hasSuffix("ラーメン"))
print(f.hasSuffix("ラーメン"))
//StringのhasPrefix、hasSuffixメソッドで、文字列の前方と後方にそれぞれ指定した文字列が含まれるか判定

let g = "This is an apple"
print(g.uppercased())  //文字列を大文字に変換
print(g.lowercased())  //文字列を小文字に変換

/*
 *
 *取り出し
 *
 */
//forループで回して文字列から１つずつCharacter型の変数に取り出す
let h = "Hello"
for ch in h.characters{ //chは変数名、「.caracters」はプロパティ
    print(ch)
}

/*
 *
 *部分文字列
 *
 */
let alphabet = "abcdefghij"
var idx: String.Index

/*var idx: String.Index //substringToIndexメソッドにはString.Index型を渡す必要がある
idx = advance(alphabet.startIndex,3)
print(alphabet.substringToIndex(idx))*/

//先頭から指定インデックスまで
// indexを取得
idx = alphabet.index(alphabet.startIndex, offsetBy: 3)
// indexを渡して、alphabetから文字列出力
print(alphabet.substring(to: idx))

print(alphabet.substring(to: alphabet.index(alphabet.startIndex, offsetBy: 3)))

//指定インデックスから終点まで
print(alphabet.substring(from: alphabet.index(alphabet.endIndex, offsetBy: -3)))

/*
 *
 *検索
 *
 */
//if let r = str.rangeOfString("def")
if let r = alphabet.range(of:"def"){
    print("見つかった")
}else{
    print("見つからない")
}
//大文字小文字を無視した検索
//if let r2 = alphabet.range(of:"DeF", options:.CaseInsensitiveSearch){
if let r2 = alphabet.range(of:"DeF", options:.caseInsensitive){
    print("見つかった")
}else{
    print("見つからない")
}

/*
 *
 *文字列補完
 文字列の中に、他の変数の値や計算結果を埋め込むことができる。
 *
 */
let title = "円の面積"
let pi = 3.14
var radius = 20
// 円の面積: 3.14 x 20 x 20 = 1256.0
print("\(title): \(pi) x \(radius) x \(radius) = \(pi * Double(radius) * Double(radius))")


/*
 *
 *ユニコード
 *
 */
// どちらもé
var aa, bb: Character
aa = "\u{00e9}"          // é
bb = "\u{0065}\u{0301}"  // é
print(aa == bb)         // true

let cc = "\u{0041}"  // 英語のA
let dd = "\u{0410}"  // ロシア語のА
print(cc == dd)     // false 文字としては別物

// U+20DDは、直前の文字を○で囲む
var ff = "ア\u{20DD}"         // ㋐

//String型の長さを調べる
//countElements
let gg = "アイウエオ"
gg.characters.count

ff.characters.count

/*
 *
 *エンコード
 *
 */
let str3 = "I \u{1F496} caf\u{E9}"
for c in str.utf8 {
    print(NSString(format: "%2X", c)); print(" ")
}
/*
 *
 *UnicodeScalar
 *
 */
var str4: String = ""
for ch in 65..<(65 + 26) {
    //str4 += Character(UnicodeScalar(ch))
    str.append(Character(UnicodeScalar(ch)!))
}
print(str4)

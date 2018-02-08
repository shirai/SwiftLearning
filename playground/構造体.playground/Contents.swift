//: Playground - noun: a place where people can play

import UIKit

/*
 *カプセル化を実現する方法としてSwiftには、クラスの他に構造体（struct）が用意されています。但し、クラスと構造体には次のような違いがあります。
 
 構造体では継承は利用できません。
 構造体にデイニシャライザは定義できません。
 クラスのインスタンスを別の変数に代入すると参照が渡されます。インスタンスの参照数は参照カウントで管理されます。対して構造体を別の変数に代入すると新たなコピーが生成されます。構造体の参照先は常に１つなので参照カウントは使用されません。
 */

struct Author {
    var name: String = "不明"
    var birthday: Date?
}

let author = Author()
print (author)

//構造体はメンバ変数を引数にもつイニシャライザが自動的に生成される
struct Author2 {
    var name: String
    var birthday: Date?
}

let formatter = DateFormatter()
formatter.dateFormat = "Y/M/d"
var author2 = Author2(name: "夏目漱石", birthday: formatter.date(from: "1867/2/9"))
print(author2)

//プロパティへのアクセスはクラスの場合と同様、.（ドット）を使う
print("著者:" + author2.name)

author2.name = "森鴎外"
author2.birthday = formatter.date(from: "1862/2/17")
print("著者:" + author2.name)

//構造体のメンバに構造体が含まれる場合は次の様に.（ドット）で繋いでアクセス
/* 書籍 */
struct Book {
    var title: String
    var author: Author
}
let book = Book(
    title: "吾輩は猫である",
    author: Author(name: "夏目漱石", birthday: formatter.date(from: "1867/2/9"))
)
print("書籍名:\(book.title), 著者:\(book.author.name)")

//定数として宣言した構造体のプロパティを変更することはできない。
let author3 = Author(name: "夏目漱石", birthday: formatter.date(from: "1867/2/9"))
//author3.name = "森鴎外"

var book1 = Book(title: "坊ちゃん", author: author)
var book2 = book1 //別の変数に代入した構造体のプロパティを変更しても、元の構造体のプロパティの値は変わらない。
book2.title = "吾輩は猫である"

print(book1.title)
print(book2.title)

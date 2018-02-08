//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var num:Int = 3+3 //変数の中身の表示
num = num+100

str = "こんにちは。" + str //文字列書き換え｀
str = "はじめまして。\(str). Nice to meet you." //\(変数名)の部分に変数の値を埋め込む
var String = Int(num)*2 //Int型からString型に置き換える

print(str) //コンソールに表示
num = 0
if num < 5{
    print("true")
    num = num+1
}

var str2 : String = "a", str3 = 1
print (str3)

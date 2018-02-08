//: Playground - noun: a place where people can play

import UIKit

/*タイプエイリアス…型の別名定義*/

typealias Money = Int
let m: Money = 100
print(m)

typealias BodyStatus = (String, Double)
var height:BodyStatus?
var weight:BodyStatus?

height = ("身長", 170.0)
weight = ("体重", 63.5)
print(height!, weight!)
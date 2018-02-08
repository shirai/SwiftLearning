//: Playground - noun: a place where people can play

import UIKit

///* 分数 */
struct Fraction {
    var numerator: Int      // 分子
    var denominator: Int    // 分母
    // 分数形式の文字列で返す
    var asString: String {
        let hcf = findHCF()
        let str = "\(abs(numerator) / hcf) / \(abs(denominator) / hcf)"
        return numerator * denominator < 0 ? "- " + str : str
    }
    // 最大公約数を求める
    func findHCF() -> Int {
        let m = max(numerator, denominator)
        for i in (1 ... m).reversed() {
            if numerator % i == 0 && denominator % i == 0 {
                return i
            }
        }
        return 1
    }
}

let f = Fraction(numerator: 6, denominator: 15)
print(f.asString)     // -> 2 / 5

/*
 *
 *2項演算子
 *
 */
/* 分数の足し算　*/
func + (left: Fraction, right: Fraction) -> Fraction {
    let numerator = left.numerator * right.denominator + right.numerator * left.denominator
    let denomitor = left.denominator * right.denominator
    return Fraction(numerator: numerator, denominator: denomitor)
}

let f1 = Fraction(numerator: 2, denominator: 3)
let f2 = Fraction(numerator: 4, denominator: 5)
let f3 = f1 + f2
print(f3.asString)

/*
 *
 *単項演算子
 *
 */
/* 符号の反転 */
prefix func - (fraction: Fraction) -> Fraction { //オペランドの前に演算子がつくのでprefixという修飾子が必要
    return Fraction(numerator: -fraction.numerator, denominator: fraction.denominator)
}

let f4 = Fraction(numerator: 4, denominator: 10)
print(f4.asString)    // -> 2 / 5
let f5 = -f4
print(f5.asString)    // -> - 2 / 5
let f6 = -f5
print(f6.asString)    // -> 2 / 5

/*
 *
 *複合代入演算子
 *
 */
/* 分数の加算　*/
func += ( left: inout Fraction, right: Fraction) { //左辺のオペランドの値は変更されるので、引数にinoutの指定が必要
    left = left + right
}

var f7 = Fraction(numerator: 2, denominator: 5)
let f8 = Fraction(numerator: 3, denominator: 4)
f7 += f8
print(f7.asString)    // -> 23 / 20

prefix func ++ ( fraction: inout Fraction) -> Fraction {
    fraction += Fraction(numerator: 1, denominator: 1)
    return fraction
}

var f9 = Fraction(numerator: 2, denominator: 3)
++f9
print(f9.asString)

/*
 *
 *等価演算子
 *
 */
/* 等価判定 */
func == (left: Fraction, right: Fraction) -> Bool {
    return left.asString == right.asString
}
func != (left: Fraction, right: Fraction) -> Bool {
    return !(left == right)
}

let f10 = Fraction(numerator: 2, denominator: 3)
let f11 = Fraction(numerator: 3, denominator: 5)
let f12 = Fraction(numerator: 4, denominator: 6)

print(f10 == f11)   // false
print(f10 == f12)   // true
print(f10 != f11)   // true

/*
 *
 *独自の演算子
 *
 */
prefix operator ~~
prefix func ~~ ( fraction: inout Fraction) -> Fraction {
    //演算子の種類に応じて、operator の前に、prefix（前に置く）, infix（間に置く）, postfix（後に置く）の何れかを指定します。ここでは、prefixを指定
    fraction = Fraction(numerator: fraction.denominator, denominator: fraction.numerator)
    return fraction
}

var f13 = Fraction(numerator: 3, denominator: 5)
~~f13
print(f13.asString)     // -> 5 / 3

var f14 = Fraction(numerator: 3, denominator: 5)
~~f14
print(f14.asString)     // -> 5 / 3


/*
 *
 *優先度と結合性
 *
 */
/* 絶対値を返す演算子　*/
infix operator |-| { associativity left precedence 140 }

/* 2つの分数の絶対値を返す */
func |-| (left: Fraction, right: Fraction) -> Fraction {
    let f = left + (-right)
    return Fraction(numerator: abs(f.numerator), denominator: abs(f.denominator))
}

let f15 = Fraction(numerator: -3 , denominator: 4)
let f16 = Fraction(numerator: 2, denominator: 5)
let f17 = f15 |-| f16
print(f17.asString)    // -> 23 / 20

/*
 *
 *
 *
 */

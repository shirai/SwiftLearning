//: Playground - noun: a place where people can play

import UIKit

/*
 *
 *宣言
 enum <>:<>{}
 *列挙型の型名とメンバ名の最初の文字は大文字にすることが推奨されています。
 */

enum Signal{ //列挙型の型名Signal
    case Blue //メンバ名
    case Yellow
    case Red
}

var s: Signal
s = Signal.Blue
s = .Blue //型（Signal）は省略できる

//１行で記載
enum Signal2 {
    case Blue, Yellow, Red
}


//列挙型の内部表現の型を次の様に明示的に指定
enum Signal3: Int{
    case Blue
    case Yellow
    case Red
}
let s3 = Signal3.Yellow
//toRawメソッドで実際の値を参照可能
print(s3.rawValue)

//fromRawメソッドで値を設定可能
let signal3 = Signal3.init(rawValue: 2)


// 整数型以外の場合は全ての値を明示する必要がある。
enum Signal4: String {
    case Blue = "青"
    case Yellow = "黄"
    case Red = "赤"
    /*case Blue2 = "青" //同じグループ（列挙型）に同じ値を入れることはできない
    それを利用して重複させたくないものをenumで列挙する、とかすることがある*/
}
let s4 = Signal4.Yellow
//toRawメソッドで実際の値を参照可能
print(s4.rawValue)

 //fromRawメソッドで値を設定可能
let signal4 = Signal4.init(rawValue: "青")

//列挙型にメソッドを定義
enum Signal5 {
    case Blue
    case Yellow
    case Red
    func meaning() -> String {
        switch(self) {
        case .Blue:
            return "進め"
        case .Yellow:
            return "注意"
        case .Red:
            return "止れ"
        }
    }
}
/*switch＋enumの組み合わせでは、
 「enumを網羅したswitch文を書く」or「case defaultを書く」
 をしないとコンパイルエラーになります。*/

let s5 = Signal5.Yellow
print(s5.meaning())

/*
 *
 *関連値
 *
 */
/* 乗り物 */
enum Vehicle {
    case Bicycle         // 自転車
    case Motorbike(Int)  // バイク（排気量）
    case Car(Int, Bool)  // 車（排気量, オートマ）
}//同じenumでもcaseごとでrawValueが異なる、ということが可能

var vehicle = Vehicle.Bicycle
vehicle = .Motorbike(750)
vehicle = .Car(1600, true)

switch vehicle {
case .Bicycle:
    print("自転車")
case .Motorbike(let engine) where engine <= 50:
    print("オートバイ:原付")
case .Motorbike(let engine) where engine <= 125:
    print("オートバイ:小型")
case .Motorbike(let engine) where engine <= 400:
    print("オートバイ:中型")
case .Motorbike(let engine):
    print("オートバイ:大型")
case .Car(let engine, let automatic) where engine <= 660:
    print("軽自動車:" + (automatic ? "オートマ" : "マニュアル"))
case .Car(let engine, let automatic):
    print("普通車 \(engine)cc:" + (automatic ? "オートマ" : "マニュアル"))
}

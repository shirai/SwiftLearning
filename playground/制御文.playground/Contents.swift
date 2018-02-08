//: Playground - noun: a place where people can play

import UIKit

/*
 *
 *if文
 *
 */
var age: Int //年齢
age = 111

if age == 61 {
    print("還暦")
} else if age == 70 {
    print("古希")
} else if age == 77 {
    print("喜寿")
} else if age == 80 {
    print("傘寿")
} else if age == 81 {
    print("半寿")
} else if age == 88 {
    print("米寿")
} else if age == 90 {
    print("卒寿")
} else if age == 99 {
    print("白寿")
} else if age == 100 {
    print("百寿")
} else if age == 108 {
    print("茶寿")
} else if age == 111 {
    print("川寿")
} else if age == 112 {
    print("珍寿")
} else if age == 118 {
    print("天寿")
} else if age == 121 {
    print("大還暦")
} else { //上のどの条件にも合致しなかった場合に実行する処理
    print("")
}

/*
 *
 *for文
    for 要素 in 要素の取り出し元 {
    処理
    }
 *
 */
let week = ["MON","TUE","WED","THU","FRI","SAT","SUN","MON"]
for day in 1...7{
    //for の後の変数は定数となります。letは不要です。但しforループの外で参照することはできません。
    var dayOfWeek = week[day]
    print("2017.8.\(day).\(dayOfWeek)")
}
//要素を使用しない場合は、_（下線）で置き換える
for _ in 0 ..< 3 {
    print("Hello")
}

//配列
let 夏の大三角 = ["ベガ","アルタイル","デネブ"]
for star in 夏の大三角{
    print(star)
}

//ディクショナリ
let 冬の大三角 = ["おおいぬ座":"シリウス","オリオン座":"ベテルギウス","こいぬ座":"プロキオン"]
for (星座,星) in 冬の大三角{
    print("\(星座)の\(星)")
}
//一つの変数に受け取る
for star in 冬の大三角{
    print("\(star.0): \(star.1)")
}

/*
 *
 *while文
    while ループの継続条件 {
    処理
    }
 *
 */
func shopping() ->Int{
    var price: Int = 108//価格
    return (price)
}

var 残高: Int = 1000//
while 0 < 残高 {
    let 価格 = shopping()
    print("\(価格)円のお買い物をしました。")
    残高 -= 価格
    if 残高 < 108 {
        print("残高\(残高)円です。もう買い物できません。")
        break //breakで処理の中断
    }
}

//ループの最後に判定する。ループの中の処理が最低１回は実行される。
repeat{ //＜変更点＞doの代わりに
    let 価格 = shopping()
    print("\(価格)円のお買い物をしました。")
    残高 -= 価格
} while 0 < 残高
print("残高\(残高)円です。")

/*forやwhileの前にラベルを書いて、continueやbreakの対象として指定することができます。内側のループから外側のループへ戻す場合に便利です。*/
let text: String = "「りんご」 「みかん」 「バナナ」"
// 「 と 」で括られた文字列の切り出し
// ＜変更点＞cライクなfor文の代わりにfor〜inを利用
outerLoop: for var index in text.characters.indices {
    var ch = text[index]
    if ch == "「" {
        var fruit = ""
        while true {
            // ＜変更点＞index.successor()の代わりにindex:after:を利用
            index = text.index(after: index)
            if index == text.endIndex {
                break outerLoop
            }
            ch = text[index]
            if ch == "」" {
                print(fruit)
                continue outerLoop
            }
            // ＜変更点＞StringにCharacterを結合するときはappendを利用する
            fruit.append(ch)
        }
    }
}


/*
 *
 *switch文
 *
 */
var coin: Int = 50 // 硬貨（円）
switch coin {
case 1, 10, 100:
    print("穴無し硬貨")
case 5, 50:
    print("穴開き硬貨")
default: //上のどの条件にも合致しなかった場合の処理
    print("不明")
}

switch coin {
case 1:
    fallthrough //複数のcaseで同じ処理をしたい場合は、次へ移るcaseの最後にfallthrough と書く
case 10:
    fallthrough
case 100:
    print("穴無し硬貨")
case 5:
    fallthrough
case 50:
    print("穴開き硬貨")
default:
    print("不明")
}

//数値以外の型も比較対象として使用できる
var signal: String = "青" // 信号機
switch signal {
case "青":
    print("進め")
case "黄":
    print("注意")
case "赤":
    print("止まれ")
default:
    print("故障？")
}

//比較対象が取り得る全ての値をcaseに網羅する必要あり
//全ての値を網羅できていればdefault:は不要
enum Signal {
    case Blue   // 青
    case Yellow // 黄
    case Red    // 赤
}
var s: Signal = .Red
switch s {
case .Blue:
    print("進め")
case .Yellow:
    break //caseに何も処理が記述されていないとエラー。何も処理したくない場合は、breakだけ記述
case .Red:
    print("止まれ")
}

//caseで範囲を指定
var num: Int = 55
switch abs(num) {   // absは絶対値を返す関数
case 0:
    print("ゼロ")
case 1..<10:
    print("1桁")
case 10..<100:
    print("2桁")
case 100..<1000:
    print("3桁")
default:
    print("4桁以上")
}

//whileで条件を指定
//複数のcaseに該当する場合、上から順に評価されて最初に該当するcaseの内容だけが実行される
switch abs(num) {   // absは絶対値を返す関数
case let n where n == 0:
    print("ゼロ")
case let n where n < 10:
    print("1桁")
case let n where n < 100:
    print("2桁")
case let n where n < 1000:
    print("3桁")
default:
    print("4桁以上")
}

//タプルを使ってswitch文で判定する例
var vehicle: (Int, Int?) // タイヤの数と排気量
vehicle = (2, 125)

switch vehicle {
case (1, _): //不要な変数は_（下線）を指定して無視
    print("一輪車")
case (2, nil):
    print("自転車")
case let (2, engine): //タイヤの数が２、さらに排気量で絞り込む
    switch engine! {
    case let e where e <= 0:
        print("バイク:排気量エラー")
    case 1...50:
        print("原付バイク")
    case 51...125:
        print("小型バイク")
    case 126...250:
        print("中型バイク")
    default:
        print("大型バイク")
    }
case (3, _):
    print("三輪車") //タイヤの数が3
case let (4, engine) where engine != nil: //タイヤの数が３、さらに排気量で絞り込む
    switch engine! {
    case let e where e <= 0:
        print("自動車:排気量エラー")
    case let e where e <= 660:
        print("軽自動車")
    default:
        print("普通車")
    }
case let (tire, engine):
    print("不明な乗り物（\(tire)輪、排気量:" + (engine == nil ? "-" : "\(engine!)cc")  + "）")
}

//通常、caseの条件文にはletを使いますが、varを使って、値を変更することも可能
let number: Int = 10

switch number {
case var n where n == 10:
    n += 20
    print(n)
default:
    break
}

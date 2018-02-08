//: Playground - noun: a place where people can play

import UIKit

/* GUI コントロール */
class GUIControl{
    var x, y, width, height: Float
    //イニシャライザ
    init(x: Float, y: Float, width: Float, height: Float){
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
}

/* ラベル */
class Label: GUIControl {
    var text: String
    init(x: Float, y : Float, width: Float, height: Float, text: String = ""){
        self.text = text
        super.init(x: x, y: y, width: width, height: height)
    }
}

/* ボタン */
class Button: Label{
    var _pushed = false
    var isPushed: Bool{
        return _pushed
    }
}

/* テキストボックス */
class TextBox: Label{
    var readOnly = false
}

// コントロールの配列
//各クラスのインスタンスの生成
let controls = [
    Label(x: 10, y: 10, width: 100, height: 30, text: "名前"),
    TextBox(x: 10, y: 10, width: 100, height: 30),
    Label(x: 10, y: 10, width: 100, height: 30, text: "住所"),
    TextBox(x: 10, y: 10, width: 100, height: 30),
    Button(x: 10, y: 10, width: 100, height: 30, text: "送信"),
    //配列に格納する方を明示していないが、全ての要素がLabelという共通クラスを継承しているため、型は自動的に、[Label]と類推される
]

//インスタンスが継承ツリーの中のあるサブクラスのインスタンスかどうか、is演算子を使って判定
var labelCount = 0      // ラベル数のカウント
var buttonCount = 0     // ボタン数のカウント
var textBoxCount = 0    // テキストボックスのカウント
//上で作成した配列をループしながら、それぞれのクラスのインスタンスの数を数える
for control in controls { //for 関数名　in ループ範囲
    if control is Button {
        buttonCount += 1
    } else if control is TextBox {
        textBoxCount += 1
    } else {
        labelCount += 1
    }
}
print("ボタン：\(buttonCount)個、テキストボックス：\(textBoxCount)個、ラベル：\(labelCount)個")

/* あるインスタンスが、あるクラス又はそのスーパークラスのインスタンスであることが明確な場合は、as!演算子を使ってその型へ変換（ダウンキャスト）することができる */
var control: GUIControl
control = controls[3]

let textBox = control as! TextBox
print(textBox)
// ダウンキャストに失敗したらnilになる
let button = control as? Button
//?...オプショナルチェイニングを使って取得した値はすべてオプショナル型となるので、その値を使うには再度アンラップが必要
print(button)
//as?演算子はオプショナル型を返すため、if文でオプショナルバインディングを使うことができる
//オプショナルバインディング...値が入っている時とnilの時とで処理を変える
for control in controls {
    if let button = control as? Button {
        let isPushed = button.isPushed ? "押された" : "押されていない"
        print("ボタン:\(button.text) \(isPushed)")
    } else if let textBox = control as? TextBox {
        let readOnly = textBox.readOnly ? "入力不可" : "入力可"
        print("テキストボックス:\(textBox.text) \(readOnly)")
    } else {
        print("ラベル:\(control.text)")
    }
}

/* AnyObjectの使用 */
/* AnyObjectはどのクラスにも適用できるので、次のようにAnyObject型の配列にLabelクラスのインスタンスを保持することもできます。配列の要素は全てLabel型なので、as!演算子を使って型キャストしても実行時エラーはおきません。 */
let objects: [AnyObject] = [
    Label(x: 10, y: 10, width: 100, height: 30, text: "名前"),
    Label(x: 10, y: 50, width: 100, height: 30, text: "住所"),
    Label(x: 10, y: 90, width: 100, height: 30, text: "電話番号"),
]

for object in objects {
    let label = object as! Label
    print("ラベル:\(label.text)")
}
for label in objects as! [Label] {
    print("ラベル:\(label.text)")
}
/* 関数型を除くあらゆる型を表すことができるため、次のようにAny型の配列にさまざまな値を保持させることができる */
let things: [Any] = [
    100,
    -23.56,
    "吾輩は猫である",
    ("救急車", 119),
    Label(x: 10, y: 10, width: 100, height: 30, text: "名前"),
    TextBox(x: 40, y: 140, width: 15, height: 20),
    Button(x: 120, y: 50, width: 100, height: 30, text: "送信")
]
for thing in things {
    switch thing {
    case 100 as Int:
        print("整数:100")
    case is Int:
        print("100以外の整数")
    case let d as Double where d < 0:
        print("負の浮動小数点数:\(d)")
    case is Double:
        print("0以上の浮動小数点数")
    case let s as String:
        print("文字列:\(s)")
    case let (contact, tel) as (String, Int):
        print("\(contact)の電話番号:\(tel)")
    case let button as Button:
        print("ボタン:\(button.text)")
    case let c as GUIControl:
        print("ボタン以外のGUIコントロール:（x:\(c.x), y:\(c.y), width:\(c.width), height:\(c.height)）")
    default:
        print("不明な型")
    }
}
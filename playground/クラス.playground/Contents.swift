//: Playground - noun: a place where people can play

import UIKit

class Monster{
    var level = 1
    var name : String?
    
    func description() -> String{
        if name == nil{
            return "不明　Lv.\(level)"
        }else{
            return "\(name!)Lv.\(level)"
        }
    }
}

/*
 *
 *インスタンスの生成
 *
 */
var monsterA = Monster() //メンバ変数,インスタンス変数,プロパティ
print(monsterA.description()) //インスタンスの属性には、インスタンス名の後に.（ドット）をつけてアクセス

var slime = Monster()
slime.name = "スライム"
print(slime.description())

monsterA.name = "スライム"

let monsterB = monsterA        // 別の変数に代入 // 定数のプロパティを変更してもエラーにならない
monsterB.name = "スライム"      // プロパティを変更
// どちらのモンスター名も同じ
print(monsterA.description())
print(monsterB.description())
/*クラスと異なり、構造体や列挙型は値渡しです。構造体のインスタンスを定数に代入した場合、プロパティは変更できません。*/

/*
 *
 *イニシャライザ　＝　コンストラクタ
 *
 */
class Player {
    var level = 1       // レベル
    var name: String    // 名前
    // イニシャライザ
    init(name: String, level: Int = 1) {
        self.name = "不明" //selfは自分自身（インスタンス）を指す。Javaのthis
    //オプショナル型以外の変数は、上のように宣言時に値を設定するか、イニシャライザの中で初期値を与える必要がある
        self.name = name
        self.level = level
       // メンバ変数の名前とイニシャライザの引数の名前が同じなので、selfを使ってメンバ変数と引数を区別する必要がある
    }
    // 説明
    func description() -> String {
        return "\(name) Lv.\(level)"
    }
}

let p = Player(name: "ネス", level: 5)
print(p.description())


/*
 *
 *デイニシャライザ
 生成されたインスタンスは、スコープを抜けたり、変数にnilや他のインスタンスが割り当てられるとメモリ上から破棄されます。この時、自動的に呼ばれるメソッドがあります。このメソッドのことをデイニシャライザ、又はデストラクタと呼びます。
 デイニシャライザの中では必要に応じて、そのクラスで確保したリソースを破棄したり、開いたファイルを閉じる、通信を切断する等の後始末的な処理を記述します。
 デイニシャライザは、deinitという名のメソッドです。deinitの後の()は不要です。引数を与えることはできません。
 *
 */
class FileHandler {
    var handle: Int
    // イニシャライザ
    init() {
        self.handle = open()
    }
    // デイニシャライザ
    deinit {
        close(b: self.handle)
    }
}

func open () -> Int{
    let a = 1
    return a
}
func close (b : Int) {
    print("\(b)デイニシャライザ成功")
}


/*
 *
 *ゲッターとセッター
 *
 */
/* BaseballPlayerクラス */
class BaseballPlayer {
    let name: String            // 名前
    var maxHitPoint: Int = 0    // 最大ヒットポイント
    var hitPoint: Int = 0       // ヒットポイント
    // レベル
    var level: Int {
        // 最大ヒットポイントはレベルに依存（下の計算は適当）
        get {   // ゲッター
            return max(1, Int(sqrt(Float(maxHitPoint - 10))))
        }
        set {   // セッター
            maxHitPoint = 10 + newValue * newValue
        }
    }
    // イニシャライザ
    init(name: String, level: Int = 1) {
        self.name = name
        self.level = level
        self.hitPoint = self.maxHitPoint
    }
    // 説明
    func description() -> String {
        return "\(name) Lv.\(level) HP(\(hitPoint)/\(maxHitPoint))"
    }
}

let goblin = BaseballPlayer(name: "ゴブリン", level: 10)
print(goblin.description())   // ゴブリン Lv.10 HP(110/110)
goblin.level = 20
print(goblin.description())   // ゴブリン Lv.20 HP(110/410)

/*
 *
 *同一インスタンスの判定
 ２つの変数が同じインスタンスを指しているかどうかは、=== 演算子を使って判定
 （==は変数が指すインスタンス同士の内容が同じかどうかの判定に使用しますが、その実装内容はクラスの設計者に依存します）
 *
 */
if monsterA === monsterB {
    print("同じインスタンス")
}
if monsterA !== monsterB {
    print("同じインスタンスではない")
}

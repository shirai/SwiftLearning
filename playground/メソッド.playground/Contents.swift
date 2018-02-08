//: Playground - noun: a place where people can play

import UIKit

/*
 *
 *インスタンスメソッド
 *
 */
/* 職種 */
enum Job {
    case Warrior, Mage, Thief, Priest
    func initialHitPoint() -> Int {
        switch self {
        case .Warrior:
            return 100
        case .Mage:
            return 40
        case .Thief:
            return 60
        case .Priest:
            return 30
        }
    }
}

/* キャラクタ */
class GameCharacter {
    var name: String
    var job: Job
    var maxHitPoint: Int {
        didSet {
            self.hitPoint = self.maxHitPoint
        }
    }
    var hitPoint: Int = 0
    // イニシャライザ
    init(name: String, job: Job) {
        self.name = name
        self.job = job
        self.maxHitPoint = self.job.initialHitPoint()
    }
    // ダメージを与える
    func addDamage(damage: Int) {
        hitPoint -= damage
        if hitPoint <= 0 {
            print("死んだ")
        }
    }
}
//インスタンスメソッドを呼び出す場合は、フロパティと同様、.（ドット）をつけて呼び出します。
var player = GameCharacter(name: "ヨシヒコ", job: .Warrior)
print(player.hitPoint)
player.addDamage(damage: 40)
print(player.hitPoint)


/*
 *
 *破壊的メソッド
 構造体、列挙型のメソッドはプロパティを変更することはできない
 mutatingをfuncの前につけて宣言することで属性値を変更できる
 定数の構造体、列挙型ではmutatingメソッドを呼び出すことはできない
 クラスの場合は変更可能
 *
 */

/* キャラクタ */
struct Character {
    var name: String
    var job: Job
    var level: Int
//    func changeJob(newJob: Job) {
//        self.job = newJob   //コンパイルエラー
    mutating func changeJob(newJob: Job) {
        self.job = newJob   //  OK
    }
}
//定数の構造体や列挙型の破壊的メソッドを呼び出す事はできない。変数であれば可能。
let player1 = Character(name: "ヨシヒコ", job: .Warrior, level: 10)
//player.changeJob(newJob:.Mage)     // コンパイルエラー

var player2 = Character(name: "ダンジョー", job: .Warrior, level: 10)
player2.changeJob(newJob: .Mage)     // OK


//破壊的メソッドでは、次のようにself自体を変更することも可能。
/* ゲームキャラクタ */
struct GameCharacter2 {
    var name: String
    var job: Job
    var level: Int
    mutating func changeJob(newJob: Job) {
        self = GameCharacter2(name: self.name, job: newJob, level: self.level)
    }
}

var player3 = GameCharacter2(name: "ヨシヒコ", job: .Warrior, level: 10)
player3.changeJob(newJob: .Mage)

print(player.job == .Mage)

/* オセロの駒 */
enum OthelloPiece {
    case White, Black
    mutating func reverse() {
        self = (self == .White ? .Black : .White)
    }
}

var piece = OthelloPiece.White
piece.reverse();
print(piece == .Black)

/*
 *
 *型メソッド
 *
 */
/* じゃんけん */
enum Janken {
    case goo, choki, paa
    static func sayPriming() {
        print("最初はグー")
    }
}
Janken.sayPriming()

/* ログイン情報 */
struct LoginInfo {
    static var url = "https://login.example.com/"
    static func isSecure() -> Bool {
        return url.hasPrefix("https:")
    }
    
    var userid: String
    var password: String
}

print(LoginInfo.isSecure())

/* パーソンクラス */
class Person {
    class var tableName: String {
        return "people" //データペーステーブル名
    }
    class func tableNameWithPrefix(prefix: String) -> String {
        return "\(prefix)_\(tableName)"
    }
    
    var name: String
    var address: String
    var tel: String
    var email: String
    init(name: String, address: String, tel: String, email: String) {
        self.name = name
        self.address = address
        self.tel = tel
        self.email = email
    }
}

print(Person.tableNameWithPrefix(prefix: "bak"))

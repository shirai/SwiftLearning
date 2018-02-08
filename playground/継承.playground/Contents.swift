//: Playground - noun: a place where people can play

import UIKit

/*
 *
 * サブクラス
 クラスを定義する時にクラス名の後に:
 *
 */
/* モンスタークラス（親） */
class Monster {
    var name: String
    var level: Int
    // イニシャライザ
    init(name: String, level: Int = 1) {
        self.name = name
        self.level = level
    }
    // ステータス表示
    func printStatus() {
        print("名前:\(name) レベル:\(level)")
    }
    // 攻撃
    func attackMonster(enemy: Monster) {
        print("\(name)は\(enemy.name)を攻撃した。");
    }
}

/* スライムクラス（子） */
class Slime: Monster {
    // イニシャライザ
    init(level: Int = 1) {
        super.init(name: "スライム", level: level) //superで、スーパークラスのメソッドやプロパティにアクセス
    }
}

/* ドラゴンクラス（子） */
class Dragon: Monster {
    // イニシャライザ
    init(level: Int = 1) {
        super.init(name: "ドラゴン", level: level) //superで、スーパークラスのメソッドやプロパティにアクセス
    }
    // 攻撃
    override func attackMonster(enemy: Monster) {
        print("\(name)は\(enemy.name)に火を吐いた。");
    }
}

let monster = Monster(name: "踊るガイコツ", level:3) //インスタンスの生成
let slime = Slime() //インスタンスの生成
let dragon = Dragon(level: 10) //インスタンスの生成
monster.printStatus() //メソッドの呼び出し
slime.printStatus() //メソッドの呼び出し
dragon.printStatus() //メソッドの呼び出し

//オーバーライド：スーパークラスのメソッド名、戻り値の型、引数の型と個数を同じにしてサブクラスで再定義すること
/* メタルスライムクラス */
class GoldSilme: Slime {
    // イニシャライザ
    override init(level: Int = 1) { //overrideを指定する
        super.init(level: level)
        self.name = "メタルスライム"
    }
}
let goldSilme = GoldSilme()
print(goldSilme.name)

/* メタルスライムクラス */
class MetalSilme: Slime {
    var isStrayed: Bool //サブクラスの自身のプロパティの初期化
    // イニシャライザ
    init(isStrayed: Bool, level: Int = 1) {
        self.isStrayed = isStrayed
        super.init(level: level)  //スーパークラスのイニシャライザ
        if self.isStrayed { //追加の設定
            self.name = "メタルスライム"
        } else {
            self.name = "はぐれメタル"
        }
    }
}

/*
 *
 *ポリモーフィズム
 *
 */
var skeleton : Monster
skeleton = Monster(name: "踊るガイコツ")
skeleton.attackMonster(enemy: slime)   // 踊るガイコツはスライムを攻撃した。  <== Monsterクラスのメソッドが呼ばれた
slime.attackMonster(enemy: skeleton)   // スライムは踊るガイコツを攻撃した。  <== Slimeクラスのメソッドが呼ばれた
dragon.attackMonster(enemy: slime)     // ドラゴンはスライムに火を吐いた。   <== Dragonクラスのメソッドが呼ばれた

/*
 *
 *オーバーライド
 *
 */
/* ポケモンクラス */
class ポケモン {
    // 名前
    var name: String
    // レベル
    var level: Int {
        didSet {
            maxHitPoint = level * 5
        }
    }
    // ヒットポイント
    var hitPoint: Int = 0 {
        didSet {
            if hitPoint <= 0 {
                print("\(name)を倒した！")
            }
        }
    }
    // 最大ヒットポイント
    var maxHitPoint: Int {
        get {
            return level * 5
        }
        set {
            level = newValue / 5
        }
    }
    // 死んだ？
    var isDead: Bool {
        return hitPoint <= 0
    }
    // イニシャライザ
    init(name: String, level: Int = 1) {
        self.name = name
        self.level = level
        self.hitPoint = self.maxHitPoint
    }
    // ダメージ計算
    func calculateDamage(enemy: ポケモン) -> Int {
        // 計算は適当
        return max(0, (level * 5 - enemy.level) + (Int(arc4random_uniform(10)) % level)) //arc4random_uniform乱数の生成
    }
    // 攻撃
    func attackMonster(enemy: ポケモン) {
        let damage = self.calculateDamage(enemy: enemy)
        print("\(name)のこうげき！\(enemy.name)は\(damage)のダメージを受けた。")
        enemy.hitPoint -= damage
    }
}

/* ピカチュウクラス　*/
class Pikatyu: ポケモン {
    override var level: Int { //オーバーライド
        didSet {
            maxHitPoint = level * 100
        }
    }
    override var maxHitPoint: Int { //オーバーライド
        get {
            return level * 100
        }
        set {
            level = newValue / 100
        }
    }
    // イニシャライザ
    init(level: Int = 1) {
        super.init(name: "ピカチュウ", level: level)
    }
    // ダメージ計算
    override func calculateDamage(enemy: ポケモン) -> Int {
        // 計算は適当
        return max(0, (level * 100 - enemy.level) + (Int(arc4random_uniform(10)) % level))
    }
}

var ポッポ, ピカチュウ: ポケモン
ポッポ = ポケモン(name: "ポッポ")
ピカチュウ = Pikatyu()
ポッポ.attackMonster(enemy: ピカチュウ)
ピカチュウ.attackMonster(enemy: ポッポ)

//マジックナンバーをリファクタリングしてクラス変数にする。
/* ポケモンクラス２ */
class ポケモン2 {
    // レベル係数
    class var levelFactor: Int {
        return 5
    }
    // 名前
    var name: String
    // レベル
    var level: Int {
        didSet {
            maxHitPoint = level * type(of: self).levelFactor
        }
    }
    // ヒットポイント
    var hitPoint: Int = 0 {
        didSet {
            if hitPoint <= 0 {
                print("\(name)を倒した！")
            }
        }
    }
    // 最大ヒットポイント
    var maxHitPoint: Int {
        get {
             return level * type(of: self).levelFactor
        }
        set {
             level = newValue / type(of: self).levelFactor
        }
    }
    // 死んだ？
    var isDead: Bool {
        return hitPoint <= 0
    }
    // イニシャライザ
    init(name: String, level: Int = 1) {
        self.name = name
        self.level = level
        self.hitPoint = self.maxHitPoint
    }
    // ダメージ計算
    func calculateDamage(enemy: ポケモン2) -> Int {
        // 計算は適当
        return max(0, (level * type(of: self).levelFactor - enemy.level)
            + (Int(arc4random_uniform(10)) % level)) //arc4random_uniform乱数の生成
    }
    // 攻撃
    func attackMonster(enemy: ポケモン2) {
        let damage = self.calculateDamage(enemy: enemy)
        print("\(name)のこうげき！\(enemy.name)は\(damage)のダメージを受けた。")
        enemy.hitPoint -= damage
    }
}

/* イーブイクラス　*/
class Eevee: ポケモン2 {
    // レベル係数
    override class var levelFactor: Int {
        return 100
    }
    override var level: Int { //オーバーライド
        didSet {
            level * type(of: self).levelFactor
        }
    }
    override var maxHitPoint: Int { //オーバーライド
        get {
            return level * type(of: self).levelFactor
        }
        set {
            level = newValue / type(of: self).levelFactor //インスタンスのクラスからクラス変数を取得
        }
    }
    // イニシャライザ
    init(level: Int = 1) {
        super.init(name: "イーブイ", level: level)
    }
    // ダメージ計算
    override func calculateDamage(enemy: ポケモン2) -> Int {
        // 計算は適当
        return max(0, (level * type(of: self).levelFactor - enemy.level) + (Int(arc4random_uniform(10)) % level)) //インスタンスのクラスからクラス変数を取得
    }
}

var プリン, イーブイ: ポケモン2
プリン = ポケモン2(name: "プリン")
イーブイ = Eevee()
プリン.attackMonster(enemy: イーブイ)
イーブイ.attackMonster(enemy: プリン)


/*
 *
 *オーバーライドの禁止
 オーバーライドを禁止するには、宣言の頭にfinalを指定
 *
 */
/* 幻のポケモンクラス */
class ReaPokemon {
    // レベル係数
    class var levelFactor: Int {
        return 100
    }

    // レベル
    final var level: Int = 0 {
        didSet {
            maxHitPoint = level * type(of: self).levelFactor
        }
    }
    // 最大ヒットポイント
    final var maxHitPoint: Int {
        get {
            return level * type(of: self).levelFactor
        }
        set {
            level = newValue / type(of: self).levelFactor
        }
    }
    // ダメージ計算
    final func calculateDamage(enemy: Monster) -> Int {
        // 計算は適当
        return max(0, (level * type(of: self).levelFactor - enemy.level) + (Int(arc4random_uniform(10)) % level))
    }
}

/* ミュウクラス */
class Miu: ReaPokemon {
//    // エラー
//    override var level: Int {
//    }
//    // エラー
//    override var maxHitPoint: Int {
//    }
//    // エラー
//    override func calculateDamage(enemy: Monster) -> Int {
//    }
//}



//クラス自体にfinalをつけて、継承を禁止
/* モンスタークラス */
final class Monster3 {
}

// エラー
//class Slime: Monster3 {
//}
}
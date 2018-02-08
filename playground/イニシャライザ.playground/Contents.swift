 //: Playground - noun: a place where people can play

import UIKit
import Foundation


/*
 *
 *構造体
 initという名の特別なメソッド。構造体とクラスで初期化のために使用
 *
 */
/* パーソン */
struct Person {
    var name: String
    var age: Int
    // イニシャライザ
    init(name: String, age: Int) { //initの前にfuncは不要。引数の内部名は自動的に外部名となる
        self.name = name
        self.age = age
    }
}
let person = Person(name:"タロウ", age: 18)
print (person)

/*
 *メンバワイズイニシャライザ
    構造体の場合は、イニシャライザを記述しないと、プロパティ値を引数にとるイニシャライザを自動的に生成
 */
/* パーソン2 */
struct Person2 {
    var name: String
    var age: Int
    // イニシャライザ
    init(_ name: String, _ age: Int) { //引数のラベルをつけたくない場合は、外部名に明示的に_（下線）を指定
        self.name = name
        self.age = age
    }
}
let person2 = Person2("タロウ", 18)
print (person2)

/*
 *デフォルトイニシャライザ
プロパティの初期値を宣言時に全て与えている場合に限り、自前でイニシャライザを用意しなくても引数をとらないイニシャライザを自動的に生成
 この場合でもメンバワイズイニシャライザも使用できる
 */
/* パーソン3 */
struct Person3 {
    var name: String = ""   // 名前
    var age: Int = 0        // 年齢
}
var taro = Person3()
taro.name = "タロウ"
taro.age = 18
var hanako = Person3(name:"ハナコ", age: 16)

//プロパティの宣言時に初期値を与えない場合は、必ずイニシャライザで初期値を与える必要がある
/* パーソン4 */
struct Person4 {
    var name: String
    var age: Int
    init() {
        name = ""
        age = 0
    }
}


/*
 *
 *クラス デフォルトイニシャライザ
 オプショナル型の場合は、宣言時やイニシャライザで初期値を設定しないとnil
 *
 */


struct Person5 {
    var name: String?
    var age: Int
    init() {
        age = 0
    }
}
var person5 = Person5()
print(person.name)

//プロパティの宣言時に初期値を与えない場合は、必ずイニシャライザで初期値を与える必要あり
/* パーソン6 */
struct Person6 {
    var name: String
    var age: Int
    init() {
        name = ""
        age = 0
    }
}

//オプショナル型の場合は、宣言時やイニシャライザで初期値を設定しないとnil
/* パーソン7 */
struct Person7 {
    var name: String?
    var age: Int
    init() {
        age = 0
    }
}
var person7 = Person7()
print(person7.name)

//自前のイニシャライザを用意する場合は、デフォルトニイシャライザやメンバワイズイニシャライザは自動的に生成されないので必要に応じて全て記述する必要があります。
/* パーソン8 */
struct Person8 {
    var name: String = ""
    var age: Int = 0
    
    // デフォルトイニシャライザ
    init() {}
    // メンバワイズイニシャライザ
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    // カスタムイニシャライザ
    init(name: String, birthday: Date) {
        // 生年月日から年齢を算出
        let components =  Calendar.current.dateComponents([Calendar.Component.year], from: birthday, to: Date())
        self.init(name: name, age: components.year!) // メンバワイズイニシャライザの呼び出し
        //イニシャライザを呼び出すことができるのは、別のイニシャライザの中からのみ。それ以外のメソッドからイニシャライザを呼び出すことはできない。
    }
}

let formatter = DateFormatter()
formatter.dateFormat = "Y/M/d"
let birthday = formatter.date(from: "1965/10/20")
let person8 = Person8(name: "タロウ", birthday: birthday!)
print(person8)

/* パーソン9 */
struct Person9 {
    var name: String
    var age: Int
    // メンバワイズイニシャライザ
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    // カスタムイニシャライザ
//    init(name: String, birthday: NSDate) {
//        self.name = name                        // initの呼び出し前にselfを使うとエラー
//        let age = self.calculateAge(birthday)   // 同上
//        self.init(name: name, age: age)         // initのselfはOK
//    }
    // 年齢計算
    func calculateAge(birthday: Date) -> Int {
        let components =  Calendar.current.dateComponents([Calendar.Component.year], from: birthday, to: Date())
        return components.year!
    }
}


/*
 *
 *関数オブジェクトによるプロパティの初期化
 *
 */
//デフォルトイニシャライザ
class Person10 {
    var name: String?
    var age: Int = 0
}
var person10 = Person10()
person10.name = "タロウ"
person10.age = 18
// 構造体と異なりメンバワイズイニシャライザは自動生成されない為、次の呼び出しはエラーになる
//var person102 = Person10(name: "タロウ", age: 0)

/*指定イニシャライザとコンビニエンスイニシャライザ
 指定イニシャライザはそのクラスの中心となるイニシャライザで、通常は全てのプロパティの初期化を行うような処理を担います。一方、コンビニエンスイニシャライザは補佐的なイニシャライザで、呼び出し方を簡便にしたり、別の引数を与えて初期化を行うような場合に使用します。クラスには最低1つ以上の指定イニシャライザが必要です。またコンビニエンスイニシャライザからは最終的に指定イニシャライザを呼び出す様にします。*/
/* パーソン11 */
class Person11 {
    var name: String
    var age: Int
    // 指定イニシャライザ
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    // コンビニエンスイニシャライザ
    convenience init(name: String, birthday: Date) {
        // 生年月日から年齢を算出
       let components =  Calendar.current.dateComponents([Calendar.Component.year], from: birthday, to: Date())
        // 指定イニシャライザの呼び出し
        self.init(name: name, age: components.year!)
    }
}
/*
 イニシャライザの自動継承
 
 ある条件の元では、スーパークラスのイニシャライザが自動的にサブクラスに継承されます。それは次の場合です。
 
 条件1
 サブクラスで指定イニシャライザを定義しない場合、スーパークラスの指定イシニャライザがそのまま継承される。
 条件2
 条件1による自動継承、或いは独自イニシャライザの提供に関わらず、スーパークラスの指定イニシャライザを全てサブクラスで定義すると、スーパークラスのコンビニエンスイニシャライザは自動的に全て継承される。これは、スーパークラスに無い新たなコンビニエンスイニシャライザを別途追加したとしても同様。
 */

/*
 *
 *イニシャライザの継承
 *
 */
/* レンタル商品 */
class RentalGoods {
    var name: String?
    var price: Int = 0
    var term: (startDate:Date, days:Int)? //タプル
    // 指定イニシャライザ
    init() {} //中身が空
    // 指定イニシャライザ
    init(name: String, price: Int, term: (Date, Int)) {
        //プロパティは全て初期値を与えているかオプショナル型なので、initの中で初期値を与えなくてもエラーにならない
        self.name = name
        self.price = price
        self.term = term
    }
    // コンビニエンスイニシャライザ
    convenience init(name: String, price: Int, days: Int) {
        // 今日を開始日とする
        self.init(name:name, price:price, term:(Date(), days)) //指定イニシャライザの呼び出し
    }
    // 内容出力
    func printDescription() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        print("商品名:\(name!)\t価格:\(price)円\tレンタル期間:\(dateFormatter.string(from: term!.startDate as Date))から\(term!.days)日間")
    }
}
var rentalGoods = RentalGoods()
rentalGoods.name = "ごんぎつね"
rentalGoods.price = 200
rentalGoods.term = (Date(), 5)
// rentalGoods.term.days = (startDate:Date: 2017/08/02 , days: 5 )
rentalGoods.printDescription()
 
 /* ネットレンタル商品 */ //レンタル商品クラスを継承
 class NetRentalGoods: RentalGoods {
    var size: Float                 //新たなプロパティ
    var unit: String = "MByte"      //新たなプロパティ
    // 指定イニシャライザ
    override init() { //引数を取らないイニシャライザはスーパークラスのイニシャライザをオーバーライド
        self.size = 0 //宣言時に初期値を与えていないので、スーバークラスのイニシャライザを呼び出す前に設定
        super.init()
    }
    // 指定イニシャライザ
    init(name: String, price: Int, term: (Date, Int), size: Float) {
        self.size = size
        super.init(name: name, price: price, term: term) //スーパークラスの指定イニシャライザを呼び出し
    }
    // コンビニエンスイニシャライザ
    convenience init(name: String, price: Int, days: Int, size: Float) {
        self.init(name: name, price: price, term: (Date(), days), size:size) //自身の指定イニシャライザを呼び出し
    }
    // 内容出力
    override func printDescription() {
        super.printDescription()
        let s = String(format: "%.2f", size) + unit
        print("容量:\(s)")
    }
 }
 var netRentalGoods = NetRentalGoods(name: "ホースと白い馬", price: 200, days: 7, size: 1.2)
 netRentalGoods.printDescription()
 
 
 /*　映画ネットレンタル商品 */ //ネットレンタル商品クラスを継承
 class MovieRentalGoods: NetRentalGoods {
    var producer: String //新たなプロパティ
    var leadingActors: String //新たなプロパティ
    var screenTime: Int //新たなプロパティ
    // 指定イニシャライザ
    override init() {
        // フェーズ1
        self.producer = ""
        self.leadingActors = ""
        self.screenTime = 0
        super.init()
        // フェーズ2
        //フェーズ2であってもスーパークラスの定数を上書きすることはできません
        self.price = 500
        self.adjustSizeUnit()
    }
    // 指定イニシャライザ
    init(name: String, price: Int, term: (Date, Int), size: Float, producer: String, leadingActors: String, screenTime: Int) {
        // フェーズ1
        self.producer = producer
        self.leadingActors = leadingActors
        self.screenTime = screenTime
        super.init(name: name, price: price, term: term, size: size)
        // フェーズ2
        self.adjustSizeUnit()
    }
    // コンビニエンスイニシャライザ
    // スーパークラスの指定イニシャライザをコンビニエンスイニシャライザとしてオーバーライドする
    override convenience init(name: String, price: Int, term: (Date, Int), size: Float) {
        self.init(name: name, price: price, term: term, size: size, producer: "", leadingActors: "", screenTime: 0)
    }
    // サイズの単位の変更
    func adjustSizeUnit() {
        if (self.size > 1024) {
            self.size /= 1024
            self.unit = "GByte"
        }
    }
    // 内容出力
    override func printDescription() {
        super.printDescription()
        print("監督:\(producer)\t主演俳優:\(leadingActors)\t上映時間:\(screenTime)分")
    }
 }
 
 let movie = MovieRentalGoods(name: "ローマの休日", price: 400, days: 2, size: 3600)
 movie.producer = "ウィリアム・ワイラー"
 movie.leadingActors = "オードリーヘップバーン, グレゴリーベック"
 movie.screenTime = 118
 movie.printDescription()

 //必須イニシャライザ
 /*イニシャライザの前にrequiredをつけて宣言した場合、そのクラスを継承するサブクラスは必ずそのイニシャライザを実装する必要があります。但し、そのイニシャライザが自動的に継承される場合は明示的に実装する必要はありません。
  サブクラスで実装する場合、そのイニシャライザの前にもrequiredをつけて宣言する必要があります。その場合、overrideは不要です。
 */
 /* ラベル */
 class Label {
    var title: String   // タイトル
    var width: Int      // 幅
    var height: Int     // 高さ
    // 指定イニシャライザ
    required init(title: String, width: Int, height: Int) {
        self.title = title
        self.width = width
        self.height = height
    }
 }
 
// /* ボタン（これはエラー） */
// class Button: Label {
//    var pushed: Bool
//    // 指定イニシャライザ
//    init(title: String, width: Int, height: Int, pushed: Bool) {
//        // 必須イニシャライザの実装が無いのでコンパイルエラー
//        super.init(title, width, height)
//    }
// }
 
 /* ボタン */
 class Button: Label {
    var pushed: Bool    // 押された？
    // 指定イニシャライザ
    required init(title: String, width: Int, height: Int) {
        self.pushed = false
        super.init(title: title, width: width, height: height)
    }
    // コンビニエンスイニシャライザ
    convenience init(title: String, width: Int, height: Int, pushed: Bool) {
        self.init(title: title, width: width, height: height)
        self.pushed = pushed
    }
 }

 /*
  *
  *関数オブジェクトによるプロパティの初期化
  *
  */
 /*
  ビンゴカード
  5 x 5 のマス目にランダムに割り当てられた1〜25の数値を持つ
  */
 struct BingoCard {
    // 各マス目の番号配列（関数オブジェクトを呼び出して初期化）
    let squares: [Int] = {
        var numbers = [Int]()
        //無名関数オブジェクトを設定し最後に()をつけて呼び出しています。
        //()がないと、関数の戻り値ではなく、関数オブジェクトそのものを割り当てることになり型が合わないためコンパイルエラーが発生します。
        for i in 1...25 {
            numbers.append(i)
        }
        var array = [Int]()
        while !numbers.isEmpty {
            let idx = Int(arc4random()) % numbers.count
            array.append(numbers.remove(at: idx))
        }
        return array
    }()
    
    // 指定マス目の番号を返す
    subscript(index: Int) -> Int {
        return squares[index]
    }
    // 全ての番号を出力
    func printNumbers() {
        print("　⭐︎　　BINGO　　⭐︎　")
        for idx in 0 ..< squares.count {
            print("\(self[idx])\t" , terminator: "")
            if (idx + 1) % 5 == 0 {
                print("")
            }
        }
    }
 }
 
 let card = BingoCard()
 card.printNumbers()
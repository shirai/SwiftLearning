//: Playground - noun: a place where people can play

import UIKit
import Foundation

/*
 *
 * 保持型プロパティ
 *
 */
class Person0 {
    let name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

var p0 = Person0(name: "岩本咲", age: 22)
p0.age = 23
//p.name = "鈴木花子"
//定数のプロパティは、初期値を設定した後は変更することはできない。


/*　保持型プロパティの宣言の前にlazyというキーワードをつけると、遅延評価させることができます。
 例えば、lazy var hoge: Hoge と宣言すると、hogeというプロパティに実際にアクセスがあるまで、hogeは生成されません。これは、生成にコストがかかるようなインスタンスで、実際にそれが使用されるとは限らないような場合に指定すると、パフォーマンスの向上が期待できます。
 */
class Hoge {
    var text: String
    init() {
        //ファイルを読んだり、ネットワークを調べたりコストのかかる処理
        text = "HogeHoge"
    }
}

class Fuga {
    lazy var hoge = Hoge()
}

let fuga = Fuga() //この時点ではまだfuga.hogeは生成されない
print(fuga.hoge.text) //ここでfuga.hogeが生成される
// 定数プロパティにlazyを指定することできません。定数はイニシャライザの完了までに値が設定されている必要があるので、lazyを指定する意味はない

// 元号情報クラス
class EraInfo {
    // 今の年号を返す
    lazy var currentEra: () -> String = {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "Y/M/d"
        let today = Date() //今日の日付を取得
        
        let startDays = [("1989/1/8", "平成"), ("1926/12/25", "昭和"), ("1912/7/30", "大正"), ("1868/10/23", "明治")]
        for day in startDays {
            if today.compare(dateFormatter.date(from: day.0)!) == ComparisonResult.orderedDescending {
                return day.1
            }
        }
        return "不明"
    }
}

let info = EraInfo() //infoオブジェクトの生成
print(info.currentEra()) //メソッドの呼び出しと出力

//後から内容を変えることも可能
info.currentEra = {
    return "へいせい"  // 常にへいせい
}
print(info.currentEra()) //メソッドの呼び出しと出力


/*
 *
 * 計算型プロパティ
 計算型プロパティは、値を保持せずに、他のプロパティの値から都度計算して結果を返したり、設定したりするプロパティです。
 値の返却と設定に、get（ゲッター）、set（セッター）を使います。
 *
 */
class Person1 {
    var birthday: Date    // 生年月日
    var age: Int {          // 年齢
        get {
            let components = self.calendar.dateComponents([Calendar.Component.year], from: birthday, to: Date())
            return components.year!
        }
        set(newAge) {
            let diff = self.age - newAge
            if diff != 0 {
                self.birthday = self.calendar.date(byAdding: Calendar.Component.year, value: diff, to: self.birthday)!
            }
        }
    }
    let dateFormatter: DateFormatter  // 日付フォーマッタ
    let calendar: Calendar            // カレンダー
    // イニシャライザ
    init(birthday: String) {
        self.dateFormatter = DateFormatter();
        self.dateFormatter.dateFormat = "Y/M/d"
            self.calendar = Calendar.current

        self.birthday = self.dateFormatter.date(from: birthday)!
    }
}

let p1 = Person1(birthday: "1980/12/31")
print(p1.age)
p1.age = p1.age - 2
print(p1.birthday)

/*
 *
 * プロパティ監視
 プロパティ値が設定される前と設定された後に処理を行うことができます。この機能をプロパティ監視と呼びます。
 値が変更される前に、willSet()が呼ばれます。また、値が変更された後に、didSet()が呼ばれます。
 *
 */
/* パーソンクラス2 */
class Person2 {
    let name: String
    var age: Int = 0 {
        willSet {
            print("\(self.age)歳から\(newValue)歳へ年齢を変更します。")
            //willSetに引数を与えない場合は、newValueで新しい値を参照できる
        }
        didSet {
            print("\(oldValue)歳から\(self.age)歳へ年齢を変更しました。")
            //didSetに引数を与えない場合は、oldValueで、変更前の値を参照できる
        }
    }
    // イニシャライザ
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let p2 = Person2(name: "山田太郎", age: 30)
p2.age = 31
//didSetの中でそのプロパティに別の値を設定すると上書きされます。willSet()やdidSet()が再度呼ばれることはありません。

/* バーソンプロトコル */
protocol PersonDelegate {
    func person(person: Person, willChangeAge age:Int)
    func person(person: Person, didChangeAge age:Int)
}

/* パーソンクラス3 */
class Person {
    var delegate: PersonDelegate?
    let name: String
    var age: Int = 0 {
        willSet(newAge) {
            delegate?.person(person: self, willChangeAge: newAge)
        }
        didSet(oldAge) {
            delegate?.person(person: self, didChangeAge: oldAge)
        }
    }
    // イニシャライザ
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

class Hoge2: PersonDelegate {
    
    init() {
        let p = Person(name: "山田太郎", age: 30)
        p.delegate = self
        print("p.age = 31")
        p.age = 31
    }
    
    func person(person: Person, willChangeAge age: Int) {
        print("willChangeAgeが呼ばれたよ")
    }
    
    func person(person: Person, didChangeAge age: Int) {
        print("didChangeAgeが呼ばれたよ")
    }
}

let hoge = Hoge2()

/*
 *
 * 型プロパティ
 クラスや構造体のインスタンスではなく、クラスや構造体、列挙型そのものにプロパティを持たせることができます。他の言語ではクラスのこのようなプロパティをクラス変数と呼んだり、静的メンバ変数と呼んだりします。
 構造体と列挙型については、保持型プロパティと計算型プロパティのどちらでも持たせることができます。クラスについては、計算型プロパティのみ持たせられます。また、クラスや構造体自体のイニシャライザが無いため、保持型プロパティは宣言時に初期値を与える必要があります。
 *
 */
//構造体の型プロパティは、staticをつけて宣言
/* ログイン情報 */
struct LoginInfo {
    static var url = "https://login.example.com/"
    static var port: Int {
        if self.url.hasPrefix("https") {
            return 443
        } else {
            return 80
        }
    }
    
    var userid: String
    var password: String
}

print(LoginInfo.url)
print(LoginInfo.port)

//列挙型の型プロパティも、staticをつけて宣言
/* 曜日 */
enum DayOfWeek: Int {
    static var firstDay: DayOfWeek {
        return .Sunday
    }
    static var lastDay: DayOfWeek {
        return .Saturday
    }
    
    case Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
}

print(DayOfWeek.firstDay.rawValue)
print(DayOfWeek.lastDay.rawValue)

//クラスの型プロパティはstatic か　classをつけて宣言
/* パーソンクラス */
class Person3 {
//    class var tableName: String {
//        return "people" // データベーステーブル名
//    }
    static var tableName = "people"
    
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

print(Person3.tableName)


//型フロパティはインスタンスの属性としてアクセスすることはできません。あくまでも型名.プロパティ名という形式でアクセスします。
/* ログイン情報 */
struct LoginInfo2 {
    static var url = "https://login.example.com/"
}

print(LoginInfo.url)

//var l = LoginInfo2(userid: "hogehoge", password: "abcd123")
//print(l.url) // エラー

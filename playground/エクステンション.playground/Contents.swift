//: Playground - noun: a place where people can play

import UIKit

/*  エクステンション...拡張
 計算型プロパティと静的な計算型プロパティ（計算型の型プロパティ）を追加できます。
 インスタンスメソッドと型メソッドを追加できます。
 イニシャライザを追加できます。（追加できるのはコンビニエンスイニシャライザのみです。指定イニシャライザやデイニシャライザは追加できません。）
 サブスクリプトを追加できます。
 ネストした型を定義してそれを使うことができます。
 新たなプロトコルに適合させることができます。 */

// 計算型プロパティの追加
extension Int{ //Int型の拡張
    //16進数
    var hex: String{
        return String(self, radix: 16)
    }
    
    //8進数
    var oct: String{
        return String(self, radix: 8)
    }
    
    //2進数
    var bin: String{
        return String(self, radix: 2)
    }
}

print(30.hex)
print(30.oct)
print(30.bin)

/* 構造体にイニシャライザを追加する */
struct Person{
    let name: String
    var email: String
    var age: Int
}

let taro = Person(name: "山田太郎", email: "taro@example.com", age: 35)
//イニシャライザの追加
extension Person {
    init(csv: String) {
        let data = csv.components(separatedBy: ",")
        var name: String? = nil
        var email: String? = nil
        var age: Int? = nil
        if data.count > 0 { name = data[0].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()}
        if data.count > 1 { email = data[1].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased() }
        if data.count > 2 { age = Int(data[2].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased())}
        self.init(name: name!, email: email!, age: age!)
    }
}

let csv: String = "\"山田次郎\", \"taro@example.com\", 35"

let ziro = Person(csv: csv)
print("名前:\(ziro.name) メール:\(ziro.email) 年齢:\(ziro.age)")

/* メソッドの追加 */
//String型に文字列を反転するreverseメソッドを追加
extension String {
    mutating func reverse() {
        var str = ""
        for ch in characters {
            str = String(ch) + str
        }
            self = str
    }
}

//受け取った関数型の処理を繰り返すメソッドを追加
extension Int {
    func times(task: () -> ()) {
        for _ in 0..<self {
            task()
        }
    }
}

3.times( task: { print("Hello, Swift") } )

/* サブスクリプトの追加 */
extension String {
    subscript(i: Int) -> Character {
        let idx = index(self.startIndex, offsetBy: i)
        //let idx = advance(self.startIndex, index)
        return self[idx]
    }
}

let text = "吾輩は猫である。"
print(text[3])

//ネストした型の追加
extension String {
    enum `Type` {
        case URL, EMail, Telephone, Other
    }
    // 文字列の種類
    var type: Type {
        // URL
        var regex = try! NSRegularExpression(pattern:"^(https?|ftp)(:\\/\\/[-_.!~*\\'()a-zA-Z0-9;\\/?:\\@&=+\\$,%#]+)$", options: NSRegularExpression.Options.caseInsensitive)

        if regex.numberOfMatches(in: self, options: [], range: NSRange(location: 0, length: self.characters.count)) > 0 {
            return .URL
        }
        // メールアドレス
        regex = try! NSRegularExpression(pattern:"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: NSRegularExpression.Options.caseInsensitive)
        if regex.numberOfMatches(in: self, options: [], range: NSRange(location: 0, length: self.characters.count)) > 0 {
            return .EMail
        }
        // 電話番号
        regex = try! NSRegularExpression(pattern:"^\\d{1,4}-?\\d{4}$|\\d{2,5}-?\\d{1,4}-?\\d{4}$", options: NSRegularExpression.Options.caseInsensitive)
        if regex.numberOfMatches(in: self, options: [], range: NSRange(location: 0, length: self.characters.count)) > 0 {
            return .Telephone
        }
        
        return .Other
    }
}

let url = "http://example.com?id=test&num=123"
print(url.type == .URL)           // true

let email = "test@example.com"
print(email.type == .EMail)       // true

let phone = "03-123-9876"
print(phone.type == .Telephone)   // true

let text2 = "Hello, Swift!"
print(text2.type == .Other)        // true

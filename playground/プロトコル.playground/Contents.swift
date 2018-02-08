//: Playground - noun: a place where people can play

import UIKit

//プロトコル...クラスに実装するプロパティとメソッドを指定する機能。プロパティとメソッドの宣言だけを記述したクラスのようなもの。
//プロトコルを定義することによって、何を実装すれば良いかが明確になる。クラスだけでなく、構造体や列挙型にも採用できる。
/*
 protocol プロトコル名 {
    プロパティ名{ get set }
    メソッド名(引数名:型) -> 戻り値の型
    func someMethod()
}
 プロトコルを適用するときは、クラス宣言で「クラス名:プロトコル名」と記述
 複数のプロトコルに適合させる場合は、プロトコルを,（カンマ）で区切って並べる。
 func someMethod(){
 :
 }
 */



/* プロパティの要求 */
// 進捗表示項目プロトコル
protocol Progressing {
    var total: Int { get }          // 総量
    var completed: Int { get set }  // 完了した量
    //プロパティの宣言時には、getterとsetterのどちらか、或いは両方を指定
//     static var numberOfProcessing: Int { get set }// 処理項目数
//    //構造体で実装する場合は、staticをつけて型プロパティとして実装する
}

struct Music: Progressing {
    let total: Int
    var completed: Int = 0
}

let music = Music(total: 1230, completed: 0)
print (music)


/* ダウンロード可能な音楽ファイルクラス　*/
class DownloadableFile: Progressing {
    let title: String           // タイトル
    let filePath: String        // ファイルのバス
    var fileSize: Int = 0       // ファイルサイズ
    var downloaded: Int = 0     // ダウンロード済みサイズ
    var amount: Int = 0
    var total: Int {
        return fileSize
    }
    var completed: Int {
        get {
            return downloaded
        }
        set {
            downloaded = newValue
        }
    }
    init(title: String, filePath: String) {
        self.title = title
        self.filePath = filePath
        // ファイルからファイルサイズを取得
        let fileManager = FileManager.default
        //if let attr = fileManager.attributesOfItemAtPath(self.filePath, error: nil) {
//        if let attr = try!fileManager.attributesOfItem(atPath: self.filePath) {
//            if let fileSize: AnyObject = attr[NSFileSize] {
//                self.fileSize = Int((fileSize as! NSInteger)._value)
//            }
//        }
        let attr = try! fileManager.attributesOfItem(atPath: self.filePath)
        if let fileSize = attr[FileAttributeKey.size] as? NSInteger  {
            self.fileSize = Int(fileSize._value)
        }
    }
}

//let tango = DownloadableFile(title: "黒猫のタンゴ", filePath: "/var/www/contents/musics/tango.mp3")
//print(tango.total)　//このパスに何もないので、エラー出て当然なのでそこは問題ない


/* メソッドの要求 */
protocol TextSerializable {
    func serialize() -> String // テキスト形式へ変換
    //{と}で囲まれた実装の部分は書かない
    //プロトコルのメソッドの宣言にデフォルト値を与えることはできない。可変個引数を使うことはできる。
    mutating func desirialize(text: String) // テキスト形式から復元
    //変更する可能性のあるメソッドのプロトコルの宣言にはmutatingが必要
}

// 書籍
struct Book: TextSerializable {
    var title: String   // タイトル
    var author: String  // 著者
    // テキスト形式へ変換
    func serialize() -> String {
        return "タイトル:\"\(title)\", 著者:\(author)"
    }
    // テキスト形式から復元
    mutating func desirialize(text: String) {
        //let elements = text.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ","))
        let elements = text.components(separatedBy: ",")
        for element in elements {
            //let e = element.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ":"))
            let e = element.components(separatedBy: ":")
           // if countElements(e.characters.count) == 2 {
            if e.count == 2 {
                switch e[0].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) {
                case "タイトル":
                    self.title = e[1]
                case "著者":
                    self.author =  e[1]
                default:
                    break
                }
            }
        }
    }
}
//Book構造体は、TextSerializableプロトコルに適合したので、TextSerializable型の変数へ代入し、メソッドを呼び出すことができる
var ts: TextSerializable = Book(title: "坊っちゃん", author: "夏目漱石")
let text = ts.serialize()
print(text)
ts.desirialize(text: text)

//テキスト形式から復元したインスタンスを返す型メソッドをプロトコルに追加
protocol TextSerializable2 {
    // テキスト形式へ変換
    func serialize() -> String
    // テキスト形式から復元
    mutating func desirialize(text: String)
    // テキスト形式から復元したインスタンスを返す
    static func deserialize(text: String) -> TextSerializable2?
}

// パーソンクラス
class Person: TextSerializable {
    var name: String    // 名前
    var age: Int?       // 年齢
    // イニシャライザ
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    // テキスト形式へ変換
    func serialize() -> String {
        return "名前:\"\(name)\", 年齢:\(age!)"
    }
    // テキスト形式から復元
    func desirialize(text: String) {
        if let p = Person.deserialize(text: text) as? Person {
            self.name = p.name
            self.age = p.age
        }
    }
    // テキスト形式から復元したインスタンスを返す
    class func deserialize(text: String) -> TextSerializable? {
        let elements = text.components(separatedBy: ",") //文字列の分割
        var name: String?, age: Int?
        for element in elements {
            let e = element.components(separatedBy: ":")
            if e.count == 2 {
                switch e[0].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) { //前後のスペースと改行を削除 
                case "名前":
                    name = e[1]
                case "年齢":
                    age = Int(e[1])
                default:
                    break
                }
            }
        }
        return name == nil ? nil : Person(name: name!, age: age!)
    }
}

let botchan = Book(title: "坊っちゃん", author: "夏目漱石")
let natume = Person(name: "夏目漱石", age: 60)
let maihime = Book(title: "舞姫", author: "森鴎外")
let mori = Person(name: "森鴎外", age: 49)

let items: [TextSerializable] = [botchan, natume, maihime, mori]
for item in items {
    print(item.serialize())
}


/*
 *
 *デリゲーション
 *
 */
/* ダウンロードプロセス */
class DownloadProcess {
    var file: DownloadableFile
    var delegate: DownloadProcessDelegate?
    init(file: DownloadableFile) {
        self.file = file
    }
    // ダウンロード処理
    func download() {
        var data: [UInt8] = [0]
        self.openStream()
        delegate?.processDidStart(process: self)
        DispatchQueue.main.async(execute: {
            let received = self.receiveData()
//            while countElements(received) > 0 {
                while  received.count > 0 {
                data += received
                self.delegate?.processDidReceiveData(process: self, data: data)
            }
            self.closeStream()
            self.delegate?.processDidEnd(process: self, data: data)
        })
    }
    // ネットワークストリームのオープン
    func openStream() {
    }
    // データの受信
    func receiveData() -> [UInt8] {
        // 受信したデータを返す
        let data: [UInt8] = [0]
        return data
    }
    // ネットワークストリームのクローズ
    func closeStream() {
    }
}

/* ダウンロードプロセスデリゲート */
protocol DownloadProcessDelegate {
    func processDidStart(process: DownloadProcess)
    func processDidReceiveData(process: DownloadProcess, data: [UInt8])
    func processDidEnd(process: DownloadProcess, data: [UInt8])
}

/* ダウンロードマネージャ */
class DownloadManager: DownloadProcessDelegate {
    var files: [DownloadableFile] = []  // ダウンロードするファイルの配列
    var downloadedSize: Int = 0         // ダウンロード済みサイズ
    
    // ファイルのダウンロード
    func downloadFiles() {
        downloadedSize = 0
        for file in files {
            let process = DownloadProcess(file: file)
            process.delegate = self
            process.download()
        }
    }
    
    // DownloadProcessからの通知
    func processDidStart(process: DownloadProcess) {
        print("\(process.file.title)のダウンロード開始")
    }
    func processDidReceiveData(process: DownloadProcess, data: [UInt8]) {
        let size = data.count
        downloadedSize += size
        print("\(process.file.title)のダウンロード中...\(size)バイト")
    }
    func processDidEnd(process: DownloadProcess, data: [UInt8]) {
        print("\(process.file.title)のダウンロード終了")
    }
}


let manager = DownloadManager()
//manager.files += [DownloadableFile(title: "黒猫のタンゴ", filePath: "/var/www/contents/musics/tango.mp3"),
//                  DownloadableFile(title: "猫踏んじゃった", filePath: "/var/www/contents/musics/nekofunda.mp3"),
//                  DownloadableFile(title: "犬のおまわりさん", filePath: "/var/www/contents/musics/inu.mp3")]
manager.downloadFiles()

/*
 *
 *エクステンションによるプロトコルへの適合
 *
 */
extension DownloadManager: Progressing {
    // ダウンロード対象の総サイズ
    var total: Int {
        var amount: Int = 0
        for file in self.files {
            amount += file.amount
        }
        return amount
    }
    // ダウンロード済みサイズ
    var completed: Int {
        get {
            return self.downloadedSize
        }
        set {
            self.downloadedSize = newValue
        }
    }
}

/*
 *
 *プロトコルの継承 *
 */
/* HTMLテキストへ変換可能なことを示すプロトコル */
protocol HTMLTranslatable: TextSerializable {
    var asHTMLText: String { get }
}

/* パーソン構造体 */
struct Person0: HTMLTranslatable {
    var name: String
    var age: Int
    func serialize() -> String {
        return name
    }
    mutating func desirialize(text: String) {
    }
    var asHTMLText: String {
        return "<span class=\"person-name-title\">名前:</span><span class=\"person-name\">\(name)</span>" +
        "<span class=\"person-age-title\">年齢:</span><span class=\"person-age\">\(age)歳</span>"
    }
}

let person: HTMLTranslatable = Person0(name: "松井イチロー", age: 41)
print(person.asHTMLText)


/*
 *
 *プロトコルの合成
 */
/* HTMLテキストへ変換可能なことを示すプロトコル */
protocol HTMLTranslatable2: TextSerializable {
    var asHTMLText: String { get }
}

/* JSON形式に相互変換可能なことを示すプロトコル */
protocol JSONSerializable2 {
    func toJSON() -> String     // JSON形式に変換
    mutating func fromJSON()    // JSON形式から復元
}

/* HTMLTranslatableとJSONSerializableに適合する型を引数にとる関数 */
//func printAsHTMLAndJSON(printTarget: HTMLTranslatable2, _: JSONSerializable2) {
//    print("HTML形式:\(printTarget.asHTMLText)\nJSON形式:\(printTarget.toJSON())")
//}
func printAsHTMLAndJSON(printTarget: HTMLTranslatable2 & JSONSerializable2) {
    print("HTML形式:\(printTarget.asHTMLText)\nJSON形式:\(printTarget.toJSON())")
}

/* パーソン構造体 */
struct Person3: HTMLTranslatable2, JSONSerializable2 {
    var name: String
    var age: Int
    func serialize() -> String {
        return name
    }
    func desirialize(text: String) {
    }
    var asHTMLText: String {
        return "<span class=\"person-name-title\">名前:</span><span class=\"person-name\">\(name)</span>" +
        "<span class=\"person-age-title\">年齢:</span><span class=\"person-age\">\(age)歳</span>"
    }
    func toJSON() -> String {
        return "{\"name\": \"\(name)\", \"age\": \(age)}"
    }
    func fromJSON() {
    }
    
}

let person3 = Person3(name: "松井イチロー", age: 41)
printAsHTMLAndJSON(printTarget: person3)


/*
 *
 *プロトコル適合の確認
 *
 */
/*あるインスタンスがプロトコルに適合しているかどうか確認したり、より具体的なプロトコルへ変換するには、型キャストで使用するis演算子やas演算子を使う事ができます。
 
 あるインスタンスがis演算子で指定したプロトコルに適合していればtrue, 適合していなければfalseが返されます。
 as?演算子を使って、あるプロトコルにダウンキャストするとそのプロトコルのオプショナル型が返されます。失敗した場合は値がnilになります。
 as演算子を使ってダウンキャストに失敗すると、実行時エラーが発生します。
 プロトコルで型キャストを使用するには、次の様にプロトコルに@objcをつけて宣言する必要があります。*/
// 進捗表示項目プロトコル
@objc protocol Progressing2 {
    var total: Int { get }          // 総量
    var completed: Int { get set }  // 完了した量
}

// 音楽クラス
class Music2: Progressing2 {
    let title: String           // タイトル
    let total: Int              // 総サイズ
    var completed: Int = 0      // 再生済みサイズ
    init(title: String, total: Int) {
        self.title = title
        self.total = total
    }
}

let music2: AnyObject = Music2(title: "黒猫のタンゴ", total: 23846)

if music is Progressing {
    print((music as Progressing).total)
}

if let total = (music as? Progressing)?.total {
    print(total)
}

/*
 *
 *プロトコルの任意要求
 *
 */
/* 翻訳プロトコル　*/
@objc protocol Translator {
    @objc optional var defaultLanguage: String { get set }    // デフォルト言語
    @objc optional func toEnglish(text: String) -> String     // 英語へ翻訳
    @objc optional func toFrench(text: String) -> String      // フランス語へ翻訳
    @objc optional func toGerman(text: String) -> String      // ドイツ語へ翻訳
}
//optionalのつけられたプロパティやメソッドが実装されているかどうかは、オプショナルの連鎖で使用する構文を使って確認
class MyTranslator: Translator {
    var defaultLanguage: String
    func toEnglish(text: String) -> String {
        if text == "こんにちは" { return "Hello"
        }else{
            return ""
        }
    }
    init(defaultLanguage: String) {
        self.defaultLanguage = defaultLanguage
    }
}

var translator: Translator?

translator = MyTranslator(defaultLanguage: "Japanese")
if let lang = translator?.defaultLanguage {
    if lang == "Japanese" {
        if let translated = translator?.toEnglish?(text: "こんにちは") {
            print(translated)     // Hello
        }
    }
}

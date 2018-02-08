//: Playground - noun: a place where people can play

import UIKit

//Int型の値の大きい方を返す関
func bigger(val1: Int, val2: Int) -> Int {
    return val1 > val2 ? val1 : val2
}
print(bigger(val1: 10, val2: 20))

var val1: Float = 10.0
var val2: Float = 20.0
//print(bigger(val1: val1, val2: val2)) // エラー

// Float型の大きい方を返す
func bigger(val1: Float, val2: Float) -> Float {
    return val1 > val2 ? val1 : val2
}

// Double型の大きい方を返す
func bigger(val1: Double, val2: Double) -> Double {
    return val1 > val2 ? val1 : val2
}

///ジェネリックス
func bigger<T : Comparable>(val1: T, val2: T) -> T {
    //関数名の後に、<と>で囲って、型を示すTという名前を指定しています。この名前はTでなくても分かり易い名前で構いませんが、慣例としてTが使われることが多いです。また、他の名前をつける場合でも大文字で始まり単語の区切りを大文字にするCamelCase（キャメルケース）にすることが推奨されています。
    
    return val1 > val2 ? val1 : val2
}
// : Comparable…SwiftにT型のオブジェクトに対して演算子<を使用できるようにするには、 TがComparableプロトコルに準拠していることを伝える必要があります。

var f1: Float = 10.0
var f2: Float = 20.0
print(bigger(val1: f1, val2: f2))

var d1: Double = 10.0
var d2: Double = 20.0
print(bigger(val1: d1, val2: d2))

var s1: String = "Mickey"
var s2: String = "Minnie"
print(bigger(val1: s1, val2: s2))

/*
 *
 *ジェネリクス型
 *
 */
// 重複要素を許可しない配列
struct Set {
    var items = [String]()
    // 要素数
    var count: Int {
        return items.count
    }
    // 要素の追加
    mutating func append(item: String) {
        if !self.contains(item: item) {
            items.append(item)
        }
    }
    // 要素の削除
    mutating func remove(item: String) {
        if let idx = items.index(of: item){
            items.remove(at: idx)
        }
    }
    // 要素の存在確認
    func contains(item: String) -> Bool {
        return items.contains(item)
    }
}

var party = Set()
party.append(item: "ルフィ")
party.append(item: "ゾロ")
party.append(item: "ナミ")
party.append(item: "ゾロ")    // 2回目×
print(party.count) // ２回目のゾロが入っていないので、３


// 重複要素を許可しない配列
struct Set2<T: Equatable> {
    var items = [T]()
    // 要素数
    var count: Int {
        return items.count
    }
    // 要素の追加
    mutating func append(item: T) {
        if !self.contains(item: item) {
            items.append(item)
        }
    }
    // 要素の削除
    mutating func remove(item: T) {
        if let idx = items.index(of: item) {
            items.remove(at:idx)
        }
    }
    // 要素の存在確認
    func contains(item: T) -> Bool {
        return items.contains(item)
    }
}

var party2 = Set2<String>()
party.append(item: "ルフィ")
party.append(item: "ゾロ")
party.append(item: "ナミ")

var numbers = Set2<Int>()
numbers.append(item: 10)
numbers.append(item: 20)
print(numbers.contains(item: 10))

/*
 *
 *関連型
 *
 */
/* ゲームボードプロトコル */
protocol GameBoard {
    associatedtype GamePiece         // ゲームの駒
    static var rows: Int { get }     // ボードの行数
    static var columns: Int { get }  // ボードの列数
    // ボードへの駒の設定/取得用サブスクリプト
    subscript(row: Int, column: Int) -> GamePiece? { get set }
}

/* オセロゲームのボード */
struct OthelloBoard: GameBoard {
    // オセロの駒
    enum OthelloPiece {
        case Black, White
    }
    static var rows: Int { return 8 }     // ボードの行数
    static var columns: Int { return 8 }  // ボードの列数
    // オセロの駒をゲームの駒として再定義
    typealias GamePiece = OthelloPiece //関連型（Associated Types）
    // マス目を表す配列
    var board = [OthelloPiece?](repeating: nil, count: 8 * 8)
    // ボードへの駒の設定/取得用サブスクリプト
    subscript(row: Int, column: Int) -> OthelloPiece? {
        get {
            return board[row * 8 + column]
        }
        set {
            board[row * 8 + column] = newValue
        }
    }
}

var board = OthelloBoard()
board[3, 3] = .Black
board[3, 4] = .White
print (board)


/* オセロゲームのボード
 オセロの駒としてBool型を使用
 */
struct OthelloBoard2: GameBoard {
    static var rows: Int { return 8 }     // ボードの行数
    static var columns: Int { return 8 }  // ボードの列数
    // マス目を表す配列
    var board = [Bool?](repeating: nil, count: 8 * 8)
    // ボードへの駒の設定/取得用サブスクリプト
    subscript(row: Int, column: Int) -> Bool? {
        get {
            return board[row * 8 + column]
        }
        set {
            board[row * 8 + column] = newValue
        }
    }
}

var board2 = OthelloBoard2()
board2[3, 3] = true
board2[3, 4] = false
//GamePieceはBool型であるということをSwiftが推論


/* オセロゲームのボード
 オセロの駒の型をジェネリクスにより汎用的にしたバージョン
 */
struct OthelloBoard3<T>: GameBoard {
    static var rows: Int { return 8 }     // ボードの行数
    static var columns: Int { return 8 }  // ボードの列数
    // マス目を表す配列
    var board = [T?](repeating: nil, count: 8 * 8)
    // ボードへの駒の設定/取得用サブスクリプト
    subscript(row: Int, column: Int) -> T? {
        get {
            return board[row * 8 + column]
        }
        set {
            board[row * 8 + column] = newValue
        }
    }
}

var board3 = OthelloBoard3<String>()
board3[3, 3] = "黒"
board3[3, 4] = "白"

/*
 *
 *where節
 *
 */
// ２つのゲームボードが同じ駒の配置か調べる関数
func isSameBoard<B1: GameBoard, B2: GameBoard>
    (someBoard: B1, anotherBoard: B2) -> Bool
    where B1.GamePiece == B2.GamePiece, B1.GamePiece: Equatable {
    if (type(of: someBoard).rows != type(of: anotherBoard).rows) ||
        (type(of: someBoard).columns != type(of: anotherBoard).columns) {
        return false
    }
        
    for row in 0 ..< type(of: someBoard).rows{
//for var row = 0; row < someBoard.dynamicType.rows; row++ {
        for col in 0 ..< type(of: someBoard).columns {
//for var col = 0; col < someBoard.dynamicType.columns; col++ {
            if someBoard[row, col] != anotherBoard[row, col] {
                return false
            }
        }
    }
    return true
}

var boardA = OthelloBoard2()
boardA[3, 3] = true; boardA[3, 4] = false; boardA[4, 3] = false; boardA[4, 4] = true;

var boardB = OthelloBoard2()
boardB[3, 3] = true; boardB[3, 4] = false; boardB[4, 3] = false; boardB[4, 4] = true;

print(isSameBoard(someBoard: boardA, anotherBoard: boardB))    // true

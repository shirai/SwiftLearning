
//: Playground - noun: a place where people can play

import UIKit

class Hoge {
    subscript(index: Int) -> Int {
        get {
            // 添字:indexの位置を値を返す
            return (index)
        }
        set(newValue) {
            // newValueを受け取る
        }
    }
}
let hoge = Hoge()
hoge[2] = 10
print(hoge[2])

class Hoge2{
    //読み出しのみでセッターが不要な場合は、ゲッターのみを記述。
    //プロパティの場合と同様、get自体の記述も不要
    subscript(index: Int) -> Int{
        return (index)
    }
}
let hoge2 = Hoge2()
// hoge2[2] = 10 ゲッターのみ
print(hoge[2])




print("_\(123)")





/*1つのクラスに引数や戻り値の型の異なる複数のサブスクリプトを定義*/
class Doubler {
    // 受け取った添字の値を2倍して返す。
    subscript(index: Int) -> Int {
        return index * 2
    }
    // 引数がString
    subscript(index: String) -> Int {
        return Int(index)! * 2 //型変換
    }
    // 戻り値がString
    subscript(index: Int) -> String {
        return "[\(index * 2)]" //文字補完
    }
}

let doubler = Doubler()
let i1: Int = doubler[3]
let i2: Int = doubler["3"]
let s: String = doubler[3]

//複数の添字を使ったサブスクリプト
class Multiplier {
    // 2つの引数の乗算結果を返す
    subscript(val1: Int, val2: Int) -> Int {
        return val1 * val2
    }
}

let m = Multiplier()
print(m[2, 3])

/* オセロのコマ */
enum Piece {
    case Black, White
}

/* オセロ盤 */
class OthelloBoard {
    class var rows: Int    { return 8 }
    class var columns: Int { return 8 }
    class var squares: Int { return rows * columns }
    var board: [Piece?]
    init() {
        board = Array(repeating: nil, count: OthelloBoard.squares)
        self[3, 3] = .Black;  self[3, 4] = .White
        self[4, 3] = .White; self[4, 4] = .Black
    }
    // 指定されたマス目のコマを返す
    subscript(row: Int, column: Int) -> Piece? {
        get {
            checkSquare(row: row, column: column)
            return board[row * OthelloBoard.columns + column]
        }
        set {
            checkSquare(row: row, column: column)
            board[row * OthelloBoard.columns + column] = newValue
        }
    }
    // 位置の検証
    func checkSquare(row: Int, column: Int) {
        assert(row < OthelloBoard.rows && column < OthelloBoard.columns, "不正な位置")
    }
}

let board = OthelloBoard()
board[3, 5] = .Black

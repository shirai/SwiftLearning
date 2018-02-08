//: Playground - noun: a place where people can play

import UIKit

/*
 *
 *宣言
    func <関数>(<引数名>:<型>)-> <戻り値の型 {<処理>} >
 *
 */
// String型とInt型の引数を受け取る関数
func assignmentFreshers(department: String, count: Int) {
    print("\(department)に\(count)人の新人が配属された！")
}
assignmentFreshers(department:"流サ事1", count:8) // 関数の呼び出し(引数名:　省略不可)

// String型とInt型の引数を受け取り、String型を返す関数
func assignmentFreshers2(department: String, count: Int) -> String{
    return "\(department)に\(count)人の新人が配属された！"
}
let message = assignmentFreshers2(department:"じゃらんゴルフ", count:1)
 print(message) // 戻り値を受け取らなくてもエラーにはならない


//タプルを戻り値とすることで複数の値を返すことができる
enum Team {
    case Golf, Beauty, スタサプ, スマデ,その他
}
// 指定された元号の名前と開始年を返す
func getFresher(team: Team) -> (teamName: String, number: Int)? {//オプショナルな戻り値を返すこともできる
    switch team {
    case .Golf:
        return ("じゃらんゴルフ", 1)
    case .Beauty:
        return ("ホットペッパービューティ", 2)
    case .スタサプ:
        return ("スタディサプリ", 1)
    case .スマデ:
        return ("スマデ", 1)
    case .その他:
        return nil
    }
}

print(getFresher(team:.Golf))
print(getFresher(team:.その他))


/*
 *
 *外部引数名
 関数の各引数には、引数名（ローカル名）の他に、分かりやすいラベル（外部名）をつけて、呼び出し時に使うことができます。ラベルをつける事で関数自体がより説明的になり機能や意味が伝わりやすくなります。
 *
 */
// RGB値を16進数文字列に変換
func calc(x a:Int, y b:Int, z c:Int) -> Int {
    // 関数内では、各引数のローカル名を使用
    return Int(a*b*c)
}

let sum = calc(x: 5, y: 16, z: 2)
print(sum)

//外部名を使いたくない場合は、次のように_（下線）を指定して無効にすることができます。（推奨はされないようです）
func encloseText2(_ text: String) -> String {//
    return (text)
}
print(encloseText2("いちご"))//Javaと同じ


/*
 *
 *引数の規定値
 関数の宣言時に引数にデフォルト（既定）値を与えることができます。
 *
 */
func encloseText(text: String, prefix: String = "(", suffix: String = ")") -> String {
    return prefix + text + suffix
}

print(encloseText(text:"みかん")) //既定値の与えられた引数を省略した場合、指定された既定値が引数として使用される
print(encloseText(text:"りんご", prefix:"【", suffix:"】"))
//引数の順番を次のようにすることも可能ですが、呼び出し方の一貫性を保つために、既定値付きの引数は引数リストの後方にもってくるように推奨されています。

/*
 *
 *可変数個引数
 *
 */
 //文字列中に指定した文字のどれかが含まれればtrueを返す
func containsCharacter(text: String, characters: Character...) -> Bool {
    for ch in characters {
        for t in text.characters {
            if ch == t {
                return true
            }
        }
    }
    return false
}

containsCharacter(text:"abcdefg", characters:"i")
containsCharacter(text:"abcdefg", characters:"g", "h", "i")

//可変数個引数は引数リストの最後に配置する必要があります。もし既定値と可変数個引数をもつ関数が必要な場合は、既定値をもつ引数の後に可変数個引数を配置するようにします。
// 可変数個引数は引数の最後に
func someFunc(arg1: Int, arg2: String = "hogehoge", arg3: Int...) {
}


/*
 *
 *定数引数と可変引数
 関数の引数はデフォルトで定数として渡されます。（letが省略されています。引数名の前にletをつけても構いません）関
 *
 */
//func printHelloMessage(text: String) {
//    text = "Hello、" + text //数の中で引数の値を変更しようとするとエラーになる。
//    print(text);
//}
//func printHelloMessage(var text: String) {
//    text = "Hello、" + text
//    print(text);
//}
//
//printHelloMessage("Swift")  // Hello, Swift

//inoutをつけると、引数として渡した可変変数を関数の中で変更して、変更後の値を関数の外側でも参照できるようになる。
func incrementBy(inc: Int, val1: inout Int, val2: inout Int) { //Swift 3以降では型名の前
    val1 += inc
    val2 += inc
}

var val1 = 100
var val2 = 200
incrementBy(inc: 10, val1: &val1, val2: &val2)
//変数を関数パラメータに渡す際には、変数の直前にアンドマーク&を付けないといけない。
print("val1=\(val1), val2=\(val2)")   // val1=110, val2=210




/*
 *
 *関数型
 *
 */
//(Int, Int) -> Intの関数
func multiply(val: Int, by: Int) -> Int {
    return val * by
}

//(String, Int) -> () の関数
func showEncounterMessage(monster: String, count: Int) {
    print("\(count)匹の\(monster)が現れた！")
}

var f: (Int, Int) -> Int //関数型の変数を宣言
f = multiply //関数名を代入して呼び出す
var v = f(10, 3) //型推論が働く為、型を宣言しなくても代入することができる
//f = showEncounterMessage //異なる型の代入は実行時エラー

//関数自体を他の関数への引数として使う
//関数①足し算
func add(a: Int, b: Int) -> Int {
    return a + b
}
//関数②引き算
func subtract(a: Int, b: Int) -> Int {
    return a - b
}
//関数③関数を渡して計算
func calculate(a: Int, b: Int, function:(Int, Int) -> Int) -> Int{ //引数に関数を受け取る
    return function(a, b)
}

print(calculate(a:10, b:20, function:add)) //関数③の呼び出し
let c = subtract //定数に関数を代入
calculate(a:10, b:20, function:c)


/*
 *
 *無名関数
 *
 */
func calculate2(a: Int, b: Int, function:(Int, Int) -> Int) -> Int{
    return function(a, b)
}

// 引数として乗算の結果を返す無名関数を記述
calculate2(a: 10, b: 20, function: {
    (val1: Int, val2: Int) in //{}でくくってinをつける、と覚えれば良さそうですね。
    return val1 * val2
})
/*さらに、無名関数の引数は上の例のように名前をつけなくても、第一引数から順に$0, $1...として参照できる。
 また値を返すだけの関数の場合、return文自体も省略できる*/
calculate2(a: 10, b: 20, function: {$0 * $1})

/*Swiftでは、演算子も関数として実装されているため、省略できる*/
calculate2(a:10, b:20, function:*)
calculate2(a:10, b:20, function:+)
calculate2(a:0, b:20, function:-)

/*引数で渡す関数が引数リストの最後の引数の場合、次のように、関数名()の後の、{ }の中に処理内容を記述することができる*/
calculate2(a:10, b:20) {
    $0 * $1
}

//呼び出す関数の引数が関数のみの場合は、関数名の後の()も不要。
func sayHello(greeting:(String) -> String) -> () { //戻り値なし
    print(greeting("Hello"))
}
sayHello { $0 } //()なし
sayHello { $0 + ", World" } //()なし
sayHello { "Hi, " + $0 } //()なし

/*
 *
 *関数のネスト
 *
 */
//関数の中で関数を作ることができる
func addAndSubtract(val1: Int, val2: Int, val3:Int) -> Int {
    func add(a: Int, b: Int) -> Int {
        return a + b
    }
    func subtract(a: Int, b: Int) -> Int {
        return a - b
    }
    var result = add(a: val1, b: val2) //add関数の呼び出し
    result = subtract(a: result, b: val3) //subtract関数の呼び出し
    return result
}
addAndSubtract(val1: 10, val2: 50, val3: 20)

/*
 *
 *クロージャ
 *
 */
func calculate(val1: Int, val2: Int, val3:Int) -> Int {
    var x: Int?
    
    func calc1(a: Int, b: Int) -> Int {
        if x == nil {
            x = 100
        }
        return a + b
    }
    func calc2(a: Int, b: Int) -> Int {
        return a - b + (x == nil ? 0 : x!) //＜条件＞ ? ＜trueの時＞ : ＜falseの時＞
        //return a - b + x ?? 0
    }
    
    var result = calc1(a: val1, b: val2) //calc1関数の呼び出し
    result = calc2(a: result, b: val3) //calc2関数の呼び出し
    return result
}

calculate(val1: 10, val2: 50, val3: 20)

//呼び出されるたびに＋１した値を返す
func makeIncrementer(initValue: Int) -> () -> Int {
    var v = initValue
    func incrementer() -> Int {
        v += 1
        return v
    }
    
    return incrementer
}

let inc = makeIncrementer(initValue: 10)
inc()
inc()
inc()

//呼び出されるたびに第２引数で指定した値を加算した値を返す
func makeIncrementer2(initValue: Int, addValue: Int) -> () -> Int {
    var v = initValue
    func incrementer() -> Int {
        v += addValue
        return v
    }
    
    return incrementer
}

let inc2 = makeIncrementer2(initValue: 10, addValue: 5)
inc2()
inc2()
inc2()

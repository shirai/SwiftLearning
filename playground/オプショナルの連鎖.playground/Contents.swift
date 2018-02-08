//: Playground - noun: a place where people can play

import UIKit

/*
 *
 *
 *
 */
class Person {
    let name: String
    var friends: [Person]?
    init(name: String) {
        self.name = name
    }
}

let taro = Person(name: "タロウ")
print(taro.friends?.count)

if let friends = taro.friends {
    print(friends.count)
}


/* 映画館クラス */
class MovieTheater {
    let name: String
    var screens: [Screen]?
    // イニシャライザ
    init(_ name: String) {
        self.name = name
    }
}

/* スクリーンクラス */
class Screen {
    var movie: Movie?           // 映画
    var sheets: [Bool]          // 座席
    // 各座席にアクセスするためのサブスクリプト
    subscript(idx: Int) -> Bool {
        get {
            return sheets[idx]
        }
        set {
            sheets[idx] = newValue
        }
    }
    // 座席数
    var numberOfSheets: Int {
        return sheets.count
    }
    // イニシャライザ
    init(numberOfSheets: Int) {
        self.sheets = Array(repeating: false, count: numberOfSheets)
    }
}

/* 映画クラス */
class Movie {
    var title: String           // タイトル
    var director: String?       // 監督
    var leadingActors: String?  // 主演
    // イニシャライザ
    init(_ title: String) {
        self.title = title
    }
    // 説明
    func printDescription() {
        print("タイトル:\(title)")
        if let director = self.director {
            print(" 監督:\(director)")
        }
        if let leadingActors = self.leadingActors {
            print(" 主演:\(leadingActors)")
        }
        print()
    }
}

//映画館クラスのインスタンス
let theater = MovieTheater("りんごシアター")
//スクリーン数（スクリーンの配列はオプショナル型）をオプショナルの連鎖を使って安全に取得
if let numScreens = theater.screens?.count {
    print("\(theater.name)のスクリーン数は\(numScreens)です。")
} else {
    print("\(theater.name)にスクリーンは有りません。")
}

// スクリーンA
let screenA = Screen(numberOfSheets: 150)
let dieHard = Movie("ダイ・ハード")
dieHard.director = "ジョン・マクティアナン"
dieHard.leadingActors = "ブルース・ウィリス"
screenA.movie = dieHard

// スクリーンB
let screenB = Screen(numberOfSheets: 200)
let terminator = Movie("ターミネーター")
terminator.director = "ジェームズ・キャメロン"
terminator.leadingActors = "アーノルド・シュワルツェネッガー"
screenB.movie = terminator

theater.screens = [screenA, screenB]

if let numScreens = theater.screens?.count {
    print("\(theater.name)のスクリーン数は\(numScreens)です。")
} else {
    print("\(theater.name)にスクリーンは有りません。")
}

//最初のスクリーンの上映映画のタイトルを表示
if let title = theater.screens?[0].movie?.title {
    print(title)
}
//オプショナルの連鎖を使わない場合、階層の途中のオプショナル型の数が増えるほどアンラップの確認のための記述が増え
if let screens = theater.screens {
    if let movie = screens[0].movie {
        print(movie.title)
    }
}

//2番目のスクリーンの、25番目のシートの空席状況を調べる
if let sheet = theater.screens?[1][24] {
    print(sheet ? "埋まってます。" : "空席です。")
}
theater.screens?[1][24] = true
if let sheet = theater.screens?[1][24] {
    print(sheet ? "埋まってます。" : "空席です。")
}

//最初のスクリーンの映画監督を出力
if let director = theater.screens?[0].movie?.director {
    print(director)
}
//値の変更
theater.screens?[0].movie?.director = "ジョン・マクティアナン（John McTiernan）"
if (theater.screens?[0].movie?.director = "ジョン・マクティアナン（John McTiernan）") != nil {
    print("監督名を変更しました。")
    //もし連鎖のいずれかのオプショナル型がnilのため値を変更できない場合は、nilが返される
}

//インスタンスメソッドの呼び出し
theater.screens?[1].movie?.printDescription()
if theater.screens?[1].movie?.printDescription() != nil {
    print("メソッドは実行されました。")
    //オプショナルの連鎖の途中がnilだった場合、メソッドは実行されない。
    //値を返さないメソッドの戻り値の型はVoidであるため、オプショナルの連鎖によるメソッド呼び出しの型はVoid?となる。
}
if let method = theater.screens?[1].movie?.printDescription {
    method()
} //事前にメソッドが実行可能かどうかを確認したい場合は、次のようにメソッド自体を戻り値としてアンラップ後実行する
//theater.screens?[1].movie?.printDescription から返される型は、printDescriptionメソッドの型 () -> () のオプショナル型
let method: (() -> ())? = theater.screens?[1].movie?.printDescription
if (method != nil) {
    method!()
}


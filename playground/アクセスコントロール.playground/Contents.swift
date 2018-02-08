//: Playground - noun: a place where people can play

import UIKit

public class SomePublicClass {}
internal class SomeInternalClass {}   //
private class SomePrivateClass {}

public var somePublicVariable = 0
internal let someInternalConstant = 0 //
private func somePrivateFunction() {}




/*
 *
 *ゲッターとセッター
 *
 */
/*
 ゲッターとセッターのアクセスレベルは、対象となる定数や変数のアクセスレベルと同じになります。
 セッターのアクセスレベルをゲッターより厳しくすることができます。
 次の例では、構造体にもプロパティにも明示的にアクセスレベルを指定していないので、アクセスレベルはデフォルトのinternalになりますが、
 プロパティのセッターにはprivateを設定しています。 */
//値の変更を追跡する文字列
struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
            print(value, numberOfEdits)
        }
    }
}
var stringToEdit = TrackedString()
stringToEdit.value = "この文字列は追跡されます。"
stringToEdit.value += "値を変更するたびに変更回数が加算されます。"
stringToEdit.value += "さらに変更します。"
print("変更回数は\(stringToEdit.numberOfEdits)回です。")
 // numberOfEdits = 0 //エラー
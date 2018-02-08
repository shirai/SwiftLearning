//: Playground - noun: a place where people can play

import UIKit

class Person{
    //血液型
    enum BloodType: String{ //enum...列挙型
        case A = "A"
        case B = "B"
        case AB = "AB"
        case O = "O"
        var asString: String{
            return self.rawValue + "型"
        }
    }
    // 体格
    struct BodySize {
        // 体型
        enum Shape {
            case Normal, Fat, Thin
            var asString: String{
                switch self{
                case .Normal:
                    return "標準体型"
                case .Fat:
                    return "太り気味"
                case .Thin:
                    return "痩せ気味"
                }
            }
        }
        var height: Float
        var weight: Float
        var bmi: Float{    // BMI ( = 体重(Kg) / (身長(m) x 身長(m)) )
            return weight / powf(height / 100.0, 2.0)
        }
        var shape: Shape{
            switch bmi {
            case let v where v < 18.5:
                return .Thin
            case let v where v >= 25.0:
                return .Fat
            default:
                return .Normal
            }
        }
    }
    let name: String
    var bloodType: BloodType
    var bodySize: BodySize
    //イニシャライザ
    init(name: String, bloodtype: BloodType, height: Float, weight: Float) {
        self.name = name
        self.bloodType = bloodType
        self.bodySize = BodySize(height: height, weight: weight)
    }
    // 詳細出力
    func printDescription() {
        print("名前:\(name) 血液型:\(bloodType.asString) 身長:\(bodySize.height)cm 体重:\(bodySize.weight)kg 体型:\(bodySize.shape.asString)")
    }
}

let iwamoto = Person(name: "", bloodType: .A, height: 170.0, weight: 60.0)
iwamoto.printDescription()

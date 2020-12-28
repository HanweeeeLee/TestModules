import UIKit

var str = "Hello, playground"

protocol MyProtocol {
    func someFunc() -> Int
}

protocol MyMainProtocol : MyProtocol {
    associatedtype MyEqatableType : Equatable
    func someFunc2() -> Bool
}

class MyMainClass: MyMainProtocol {

    typealias MyEqatableType = String

    func someFunc() -> Int {return 1}
    func someFunc2() -> Bool {return true}
}

//func commonGenericErrFunc() -> MyMainProtocol {
//    return MyMainClass()
//}

func commonGenericFunc<T: MyMainProtocol>() -> T {
    print("associatedtype이 존재하는 프로토콜을 리턴해주기 위해서는? 제네릭을 이용해 리턴해줘야한다.")
    return MyMainClass() as! T
}

func commonGenericFunc2() -> some MyMainProtocol {
    print("이렇게도 된다. 이런식으로 opaqueType을 써서 얻는 이득은? 불투명 타입은 동일 함수에 대한 모든 호출이 같은 타입을 반환한다는 것을 보장함")
    return MyMainClass()
}



print("end")

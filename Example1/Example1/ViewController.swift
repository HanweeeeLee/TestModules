//
//  ViewController.swift
//  Example1
//
//  Created by hanwe on 2020/05/20.
//  Copyright © 2020 hanwe. All rights reserved.
//

/*
1. 다음 물음에 답하시오
 A. 클래스에서 IBOutlet 변수는 어떤 변수이며 언제 생성되는가?
    Interface Builder Outlet의 약자, xib에서 class로 컨트롤러 객체를 가져다 사용 할 수 있게 만드는 변수. xib내부의 컨트롤러를 우클릭 후 해당 xib가 상속받은 클래스파일로 드레그 해서 생성 할 수 있다.
 B. 커넥션 인스펙터(Connections Inspector)에서 알 수 있는 정보는 무엇인가?
    어떤 컨트롤러가 어떤IBOutlet과 연결되었는지 확인 할 수 있다.
 C. 스위프트에서 구조체와 클래스의 가장 큰 차이점이 무엇인가?
    구조체는 value타입이며 클래스는 reference타입이다.
 D. Xcode에서 변수의 데이터 타입을 알 수 있는 단축키는 무엇인가?
    커멘드 + 컨트롤 클릭? 변수명을 var myString:String = ""와 같이 명시하지 않으면 컴파일하면서 컴파일러가 해당 변수의 타입을 정해주는것으로 알고있음. 어떤답변을 원하는지..? 해당 변수의 정의를 보기위해선 커멘드 + 컨트롤 + 클릭으로 이동 할 수 있음.
    
 */
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func getCatImgAction(_ sender: Any) {
        let myRemoteServer = RemoteServer()
        myRemoteServer.requestImage(style: "cat") { (image) in
            if image != nil {
                DispatchQueue.main.async {
                    self.imageView.image = image! //UI변경은 main스레드에서
                }
            }
            else {
                print("nil")
            }
        }
    }
    
}




//
//  ViewController.swift
//  MoyaSample
//
//  Created by hanwe lee on 2021/03/18.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import SwiftyJSON
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    private let userInfos: BehaviorSubject<[GithubUserData]> = BehaviorSubject<[GithubUserData]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "MyTableViewCell")
        self.searchBar.rx.text
            .orEmpty
            .debounce(.milliseconds(700), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                self?.search(text: query)
            })
            .disposed(by: disposeBag)
        
        self.userInfos.bind(to: self.tableView.rx.items) { tableView, row, githubUsers in
            let cell: MyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell") as! MyTableViewCell
            cell.userName.text = githubUsers.name
            cell.imgView.kf.setImage(with: URL(string: githubUsers.imgUrl))
            print("\(githubUsers.name)")
            return cell
        }
        .disposed(by: self.disposeBag)
        
        self.tableView.rx.setDelegate(self)
            .disposed(by: self.disposeBag)
        
        
        
    }


    private func search(text: String) {
        let provider = MoyaProvider<GithubAPI>()
        provider.rx.request(.searchUser(query: text))
            .subscribe { [weak self] event in
                switch event {
                case .success(let response):
                    print("response:\(response)")
                    let responseJson = try! JSON(data: response.data)
                    let items = responseJson["items"]
                    var models: [GithubUserData] = []
                    for i in 0..<items.count {
                        if let model: GithubUserData = GithubUserData.fromJson(jsonData: items[i].rawString()?.data(using: .utf8), object: GithubUserData()) {
                            models.append(model)
                        }
                    }
                    self?.userInfos.onNext(models)
                    break
                case .error(let error):
                    print("error:\(error.localizedDescription)")
                }
            }
            .disposed(by: self.disposeBag)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}


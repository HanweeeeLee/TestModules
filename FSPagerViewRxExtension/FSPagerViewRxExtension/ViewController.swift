//
//  ViewController.swift
//  FSPagerViewRxExtension
//
//  Created by hanwe lee on 2021/06/28.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    var disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 프로젝트 샘플코드
        let pagerView = FSPagerView(frame: view.bounds)
        pagerView.isInfinite = true
        pagerView.automaticSlidingInterval = 2
        pagerView.itemSize = view.bounds.size
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "FSPagerViewCell")
        view.addSubview(pagerView)

        let pageControl = FSPageControl(frame: CGRect(x: 0, y: view.bounds.height - 60, width: view.bounds.width, height: 30))
        view.addSubview(pageControl)

        let items = Driver.of(["image0", "image1", "image2", "image3"])
        items.drive(pagerView.rx.items(cellIdentifier: "FSPagerViewCell")) { _, item, cell in
            cell.imageView?.image = UIImage(named: item)
        }.disposed(by: disposeBag)
        items.map { $0.count }.drive(pageControl.rx.numberOfPages).disposed(by: disposeBag)

        pagerView.rx.itemSelected.subscribe(onNext: { index in
            debugPrint(index)
        }).disposed(by: disposeBag)

        pagerView.rx.modelSelected(String.self).subscribe(onNext: { image in
            debugPrint(image)
        }).disposed(by: disposeBag)

        pagerView.rx.itemScrolled.asDriver().drive(pageControl.rx.currentPage).disposed(by: disposeBag)
        // 프로젝트 샘플코드
    }


}


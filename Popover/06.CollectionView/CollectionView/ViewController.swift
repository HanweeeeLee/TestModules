//
//  ViewController.swift
//  CollectionView
//
//  Created by hanwe lee on 2020/06/22.
//  Copyright © 2020 hanwe lee. All rights reserved.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController, WMPopoverContainerViewDelegate {
  
  let baseView = UIView()
  let myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
  
  lazy var test = WMPopoverContainerView(itemList: [
    .init(rawValue: 1, name: "테스트", nameFont: .boldSystemFont(ofSize: 13), nameTextColor: .black, backgroundColor: .white, highlightColor: .lightGray, icon: nil, iconColor: .yellow),
    .init(rawValue: 2, name: "테스트2", nameFont: .boldSystemFont(ofSize: 13), nameTextColor: .black, backgroundColor: .white, highlightColor: .lightGray, icon: nil, iconColor: .yellow),
    .init(rawValue: 3, name: "테스트3", nameFont: .boldSystemFont(ofSize: 13), nameTextColor: .black, backgroundColor: .white, highlightColor: .lightGray, icon: nil, iconColor: .yellow),
    .init(rawValue: 4, name: "테스트4", nameFont: .boldSystemFont(ofSize: 13), nameTextColor: .black, backgroundColor: .white, highlightColor: .lightGray, icon: nil, iconColor: .yellow),
    .init(rawValue: 5, name: "테스트5", nameFont: .boldSystemFont(ofSize: 13), nameTextColor: .black, backgroundColor: .white, highlightColor: .lightGray, icon: nil, iconColor: .yellow),
    .init(rawValue: 6, name: "테스트6", nameFont: .boldSystemFont(ofSize: 13), nameTextColor: .black, backgroundColor: .white, highlightColor: .lightGray, icon: nil, iconColor: .yellow),
    .init(rawValue: 7, name: "테스트7", nameFont: .boldSystemFont(ofSize: 13), nameTextColor: .black, backgroundColor: .white, highlightColor: .lightGray, icon: nil, iconColor: .yellow),
    .init(rawValue: 8, name: "테스트8", nameFont: .boldSystemFont(ofSize: 13), nameTextColor: .black, backgroundColor: .white, highlightColor: .lightGray, icon: nil, iconColor: .yellow)
  ])
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(self.baseView)
    self.baseView.snp.makeConstraints {
      let safeGuide = self.view.safeAreaLayoutGuide
      $0.edges.equalTo(safeGuide)
    }
    
    self.baseView.addSubview(self.myCollectionView)
    self.myCollectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    self.myCollectionView.delegate = self
    self.myCollectionView.dataSource = self
    self.myCollectionView.register(UINib(nibName: "MyCell", bundle: nil), forCellWithReuseIdentifier: "MyCell")
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 10
    self.myCollectionView.collectionViewLayout = layout
    self.myCollectionView.showsHorizontalScrollIndicator = false
    self.myCollectionView.showsVerticalScrollIndicator = false
    

    self.baseView.addSubview(test)
    test.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    self.test.delegate = self
  }
  
  
  func tappedFunction(rawValue: Int) {
    print("infoData: \(rawValue)")
    self.test.inactive()
  }
  
  func tappedEmoji(emoji: String) {
    print("emoji: \(emoji)")
    self.test.inactive()
  }
  
}

extension ViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource, MyCellDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let resultCnt = 100
    
    return resultCnt
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
    cell.delegate = self
    if indexPath.item%2 == 0 {
      cell.myImgView.image = UIImage(named: "1")
      cell.myLabel.text = "hello"
    }
    else {
      cell.myImgView.image = UIImage(named: "2")
      cell.myLabel.text = "hi"
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellSize:CGSize = CGSize(width: UIScreen.main.bounds.width - 50, height: 100)
    
    return cellSize
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    let edgeInsets:UIEdgeInsets = .init(top: 100,
                                        left: 0,
                                        bottom: 0,
                                        right: 0)
    return edgeInsets
  }
  
  func test(_ cell: UICollectionViewCell, bounds: CGRect) {
    if !self.test.isActive {
      self.test.active(parentsView: cell)
    }
  }
  
}


//
//  HWPagerView.swift
//  HWPagerView
//
//  Created by hanwe lee on 2020/09/28.
//

import UIKit
import SnapKit

protocol HWPagerViewDelegate:class {
    
}

extension HWPagerViewDelegate {
    
}

protocol HWPagerViewDatasource:class {
    func hwPagerView(_ hwPagerView:HWPagerView) -> Int
    func hwPagerView(_ hwPagerView:HWPagerView,cellForItemAt itemAt: UInt) -> HWPagerViewCell
}

extension HWPagerViewDatasource {
    
}

class HWPagerView: UIView {
    
    //MARK: property
    
    weak var delegate:HWPagerViewDelegate?
    weak var datasource:HWPagerViewDatasource?
    
    //MARK: privateProperty
    
    private lazy var collectionView:UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: UICollectionViewFlowLayout.init())
    private var numberOfItems:UInt = 0
    var currentPage:UInt = 0
    lazy var onceMoveWidth:CGFloat = self.bounds.width
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("언제쯤이지")
        testFunc()
    }
    
    //MARK: public func
    
    public func register(_ cellClass:UINib, _ forCellWithReuseIdentifier:String) {
        self.collectionView.register(cellClass, forCellWithReuseIdentifier: forCellWithReuseIdentifier)
    }
    
    public func dequeueReusableCell(withReuseIdentifier:String,index at:UInt) -> HWPagerViewCell {
        return self.collectionView.dequeueReusableCell(withReuseIdentifier: withReuseIdentifier, for: IndexPath(item: Int(at), section: 0)) as! HWPagerViewCell
    }
    
    func testFunc() {
        self.collectionView.contentOffset = CGPoint(x: self.onceMoveWidth, y: 0)
    }
    
    //MARK: private func
    
    func initUI() { //todo private
        print("initUI")
        self.collectionView.backgroundColor = .clear
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(0)
            make.trailing.equalTo(self.snp.trailing).offset(0)
            make.top.equalTo(self.snp.top).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(0)
        }
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isPagingEnabled = true
        
//        self.collectionView.decelerationRate =
//        self.collectionView.decelerationRate.rawValue = 0
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
//        layout.sectionInset = UIEdgeInsets(top: 0, left: self.onceMoveWidth, bottom: 0, right: 0)
        self.collectionView.collectionViewLayout = layout
    }
    
    func movePage(page:UInt) {
        self.collectionView.scrollToItem(at: IndexPath(item: Int(page), section: 0), at: .left, animated: true)
    }
    
    func scrollViewWillEndDragging (scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        targetContentOffset.memory = scrollView.contentOffset
        print("언제호출?")
    }
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        print("호출?")
        scrollView.setContentOffset(scrollView.contentOffset, animated: true)
    }
    
    //MARK: action
    
    
}

extension HWPagerView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let ds = self.datasource else { return 0 }
        self.numberOfItems = UInt(ds.hwPagerView(self))
        return Int(self.numberOfItems + 2)
//        return Int(self.numberOfItems)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if indexPath.item == 0 {
            cell = self.datasource!.hwPagerView(self, cellForItemAt: UInt(self.numberOfItems - 1))
        }
        else if indexPath.item == self.numberOfItems + 1 {
            cell = self.datasource!.hwPagerView(self, cellForItemAt: UInt(0))
        }
        else {
            cell = self.datasource!.hwPagerView(self, cellForItemAt: UInt(indexPath.item - 1 ))
        }
//        cell = self.datasource!.hwPagerView(self, cellForItemAt: UInt(indexPath.item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {// 화면회전 고려는 나중에
        return CGSize(width: self.bounds.width, height: self.bounds.height)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("drag start")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("endDrag")
//        self.currentPage = UInt(scrollView.contentOffset.x/self.onceMoveWidth)
//        if (scrollView.contentOffset.x.truncatingRemainder(dividingBy: self.onceMoveWidth)) > (self.onceMoveWidth/2) {
//            self.currentPage += 1
//        }
//        movePage(page: self.currentPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("scroll x:\(scrollView.contentOffset.x)")
//        print("currentPage:\(UInt(scrollView.contentOffset.x/self.onceMoveWidth))")
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let currentPage:Int = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        let page = UInt(scrollView.contentOffset.x/self.onceMoveWidth)
        self.currentPage = page
//        if page + 1 > self.currentPage {
//            self.currentPage += 1
////            movePage(page: self.currentPage)
//        }
//
//        if page > 0 {
//            if page - 1 < self.currentPage {
//                self.currentPage -= 1
////                movePage(page: self.currentPage)
//            }
//        }
        print("currentPage:\(self.currentPage)")
        if currentPage == 0 {
            self.collectionView.contentOffset = CGPoint(x: scrollView.frame.size.width * CGFloat(numberOfItems), y: scrollView.contentOffset.y)
        }
        else if currentPage == numberOfItems+1 {
            print("안들어오지않나")
            self.collectionView.contentOffset = CGPoint(x: self.onceMoveWidth, y: scrollView.contentOffset.y)
        }
    }
    
}

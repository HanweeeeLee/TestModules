//
//  TabPagerHeaderView.swift
//  StackPagerView
//
//  Created by Aaron Hanwe LEE on 2022/08/26.
//

import UIKit
import SnapKit
import Then
import RxCocoa

protocol TabPagerHeaderViewDelegate: AnyObject {
    func didSelected(_ view: TabPagerHeaderView, index: Int)
}

class TabPagerHeaderView: UIView {
    
    // MARK: private UI property
    
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.delaysContentTouches = false
    }
    
    private let stackView = UIStackView().then {
        $0.backgroundColor = .brown
        $0.axis = .horizontal
    }
    
    // MARK: internal UI property
    
    // MARK: private property
    
    private var cellList: [TabPagerHeaderCellView] = []
    private let menuList: [String]
    
    // MARK: property
    
    weak var delegate: TabPagerHeaderViewDelegate?
    
    let leadingInset: Int
    let trailingInset: Int
    let cellSpacing: Int
    
    private(set) var currentSelectedIndex: Int = 0
    
    // MARK: lifeCycle
    
    init(menuList: [String], leadingInset: Int, trailingInset: Int, cellSpacing: Int) {
        self.leadingInset = leadingInset
        self.trailingInset = trailingInset
        self.cellSpacing = cellSpacing
        self.menuList = menuList
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.cellList.removeAll()
        print("\(self) deinit")
    }
    
    // MARK: private func
    
    private func setup() {
        
        self.addSubview(scrollView)
        self.scrollView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        self.scrollView.addSubview(self.stackView)
        self.stackView.snp.makeConstraints {
            $0.edges.equalTo(self.scrollView)
        }
        let leadingInsetView = UIView().then {
            $0.backgroundColor = .clear
        }
        leadingInsetView.snp.makeConstraints {
            $0.width.equalTo(self.leadingInset)
        }
        self.stackView.addArrangedSubview(leadingInsetView)
        for i in 0..<self.menuList.count {
            let item = self.menuList[i]
            let cell = TabPagerHeaderCellView(title: item,
                                              index: i,
                                              selectedFont: .systemFont(ofSize: 30),
                                              unselectedFont: .systemFont(ofSize: 25),
                                              selectedColor: .black,
                                              unselectedColor: .lightGray)
            if i == 0 { // 첫번째 인덱스 default 선택됨으로
                cell.isSelected = true
            }
            cell.delegate = self
            self.cellList.append(cell)
            self.stackView.addArrangedSubview(cell)
            if i != self.menuList.count - 1 { // 마지막 셀이 아니라면
                let spacingView = UIView().then {
                    $0.backgroundColor = .clear
                }
                spacingView.snp.makeConstraints {
                    $0.width.equalTo(self.cellSpacing)
                }
                self.stackView.addArrangedSubview(spacingView)
            }
        }
        let trailingInsetView = UIView().then {
            $0.backgroundColor = .clear
        }
        trailingInsetView.snp.makeConstraints {
            $0.width.equalTo(self.leadingInset)
        }
        self.stackView.addArrangedSubview(trailingInsetView)
    }
    
    // MARK: func

}

extension TabPagerHeaderView: TabPagerHeaderCellViewDelegate {
    func didSelected(view: TabPagerHeaderCellView, index: Int) {
        if index != self.currentSelectedIndex {
            self.cellList[self.currentSelectedIndex].isSelected = false
            self.cellList[index].isSelected = true
            self.currentSelectedIndex = index
            for item in self.stackView.subviews where item == self.cellList[index] {
                let xPoint: CGFloat = {
                    var result: CGFloat = 0
                    result = item.frame.midX - (self.frame.width / 2)
                    if result < 0 {
                        result = 0
                    }
                    if result >= self.scrollView.contentSize.width - UIScreen.main.bounds.width {
                        result = self.scrollView.contentSize.width - UIScreen.main.bounds.width
                    }
                    return result
                }()
                self.scrollView.setContentOffset(CGPoint(x: xPoint, y: 0), animated: true)
            }
            self.delegate?.didSelected(self, index: index)
        }
    }
}

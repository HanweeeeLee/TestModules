//
//  TabPagerHeaderCellView.swift
//  StackPagerView
//
//  Created by Aaron Hanwe LEE on 2022/08/26.
//

import UIKit
import SnapKit
import Then

protocol TabPagerHeaderCellViewDelegate: AnyObject {
    func didSelected(view: TabPagerHeaderCellView, index: Int)
}

class TabPagerHeaderCellView: UIView {
    
    // MARK: private UI property
    
    private lazy var titleLabel = UILabel().then {
        $0.text = self.title
        $0.isUserInteractionEnabled = true
        $0.textColor = self.unselectedColor
        $0.font = self.unselectedFont
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(_:)))
        $0.addGestureRecognizer(tapGesture)
    }
    
    // MARK: internal UI property
    
    // MARK: private property
    
    let selectedFont: UIFont
    let unselectedFont: UIFont
    let selectedColor: UIColor
    let unselectedColor: UIColor
    
    // MARK: property
    
    let title: String
    
    var isSelected: Bool = false {
        didSet {
            let isSelected = self.isSelected
            DispatchQueue.main.async { [weak self] in
                if isSelected {
                    self?.refreshSelectedUI()
                } else {
                    self?.refreshUnselectedUI()
                }
            }
        }
    }
    
    let index: Int
    
    weak var delegate: TabPagerHeaderCellViewDelegate?
    
    // MARK: lifeCycle
    
    init(title: String, index: Int, selectedFont: UIFont, unselectedFont: UIFont, selectedColor: UIColor, unselectedColor: UIColor) {
        self.selectedFont = selectedFont
        self.unselectedFont = unselectedFont
        self.selectedColor = selectedColor
        self.unselectedColor = unselectedColor
        self.title = title
        self.index = index
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private func
    
    private func setup() {
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    
    private func refreshSelectedUI() {
        self.titleLabel.font = self.selectedFont
        self.titleLabel.textColor = self.selectedColor
    }

    private func refreshUnselectedUI() {
        self.titleLabel.font = self.unselectedFont
        self.titleLabel.textColor = self.unselectedColor
    }
    
    @objc func tapAction(_ recognizer: UITapGestureRecognizer) {
        self.delegate?.didSelected(view: self, index: self.index)
    }
    
    // MARK: func
    
}

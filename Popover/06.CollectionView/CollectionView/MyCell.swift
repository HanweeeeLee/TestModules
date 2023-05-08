//
//  MyCell.swift
//  CollectionView
//
//  Created by hanwe on 2020/07/11.
//  Copyright © 2020 hanwe lee. All rights reserved.
//

import UIKit

protocol MyCellDelegate: AnyObject {
  func test(_ cell: UICollectionViewCell, bounds: CGRect)
}

class MyCell: UICollectionViewCell {
  
  @IBOutlet weak var mainContainerView: UIView!
  @IBOutlet weak var myImgView: UIImageView!
  @IBOutlet weak var myLabel: UILabel!
  
  weak var delegate: MyCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    myImgView.contentMode = .scaleAspectFill
    self.myLabel.textColor = .white
    let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
    self.contentView.addGestureRecognizer(longPressRecognizer)
  }
  
  @objc func longPressed(sender: UILongPressGestureRecognizer) {
    print("longPressed")
    self.delegate?.test(self, bounds: self.bounds)
  }
  
}

//
//  CellType2CollectionViewCell.swift
//  RxDatasourceMultiCell
//
//  Created by Aaron Hanwe LEE on 2022/07/13.
//

import UIKit

class CellType2CollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  ViewController.swift
//  RxDatasourceMultiCell
//
//  Created by Aaron Hanwe LEE on 2022/07/13.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift
import Differentiator
import SnapKit
import Then

class ViewController: UIViewController {
    
    // MARK: private UI property
    
    // MARK: internal UI property
    
    // MARK: private property
    
    private lazy var collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewLayout()).then {
           $0.delaysContentTouches = false
           $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
           $0.alwaysBounceVertical = true
           
           let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
           layout.minimumLineSpacing = 0
           layout.minimumInteritemSpacing = 24
           layout.scrollDirection = .vertical
           layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 1.08)
           layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 60)
           $0.collectionViewLayout = layout
       }
    
    private let disposeBag = DisposeBag()
    
    // MARK: property
    
    // MARK: lifeCycle
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(collectionView)
        self.collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.view)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(CellType1CollectionViewCell.self, forCellWithReuseIdentifier: "CellType1CollectionViewCell")
        self.collectionView.register(CellType2CollectionViewCell.self, forCellWithReuseIdentifier: "CellType2CollectionViewCell")
        print("hello world")
        let sections: [MultipleSectionModel] = [
            .ImageProvidableSection(title: "Section 1",
                items: [.ImageSectionItem(image: UIImage(named: "settings")!, title: "General")]),
            .ToggleableSection(title: "Section 2",
                items: [.ToggleableSectionItem(title: "On", enabled: true)]),
            .StepperableSection(title: "Section 3",
                items: [.StepperSectionItem(title: "1")])
        ]
        
        let dataSource = ViewController.dataSource()
        
        Observable.just(sections)
            .bind(to: self.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
    }
    
    // MARK: private func
    
    // MARK: func


}

extension ViewController {
    
    static func dataSource() -> RxCollectionViewSectionedReloadDataSource<MultipleSectionModel> {
        return RxCollectionViewSectionedReloadDataSource<MultipleSectionModel>(
            configureCell: { dataSource, collectionView, indexPath, item in
                switch item {
                case .ImageSectionItem(let image, let title):
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellType1CollectionViewCell", for: indexPath) as? CellType1CollectionViewCell else { return UICollectionViewCell() }
                    return cell
                case .StepperSectionItem(let title):
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellType1CollectionViewCell", for: indexPath) as? CellType1CollectionViewCell else { return UICollectionViewCell() }
                    return cell
                case .ToggleableSectionItem(let title, let enabled):
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellType2CollectionViewCell", for: indexPath) as? CellType2CollectionViewCell else { return UICollectionViewCell() }
                    return cell
                }
            }
        )
    }
}

enum MultipleSectionModel {
    case ImageProvidableSection(title: String, items: [SectionItem])
    case ToggleableSection(title: String, items: [SectionItem])
    case StepperableSection(title: String, items: [SectionItem])
}

enum SectionItem {
    case ImageSectionItem(image: UIImage, title: String)
    case ToggleableSectionItem(title: String, enabled: Bool)
    case StepperSectionItem(title: String)
}

extension MultipleSectionModel: SectionModelType {
    typealias Item = SectionItem
    
    var items: [SectionItem] {
        switch  self {
        case .ImageProvidableSection(title: _, items: let items):
            return items.map { $0 }
        case .StepperableSection(title: _, items: let items):
            return items.map { $0 }
        case .ToggleableSection(title: _, items: let items):
            return items.map { $0 }
        }
    }
    
    init(original: MultipleSectionModel, items: [Item]) {
        switch original {
        case let .ImageProvidableSection(title: title, items: _):
            self = .ImageProvidableSection(title: title, items: items)
        case let .StepperableSection(title, _):
            self = .StepperableSection(title: title, items: items)
        case let .ToggleableSection(title, _):
            self = .ToggleableSection(title: title, items: items)
        }
    }
}

extension MultipleSectionModel {
    var title: String {
        switch self {
        case .ImageProvidableSection(title: let title, items: _):
            return title
        case .StepperableSection(title: let title, items: _):
            return title
        case .ToggleableSection(title: let title, items: _):
            return title
        }
    }
}

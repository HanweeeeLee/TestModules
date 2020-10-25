//
//  ViewController.swift
//  HWCollectionViewDemo
//
//  Created by hanwe on 2020/10/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: HWCollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib.init(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyCollectionViewCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        self.collectionView.collectionViewLayout = layout
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = true
    }

}

extension ViewController: HWCollectionViewDelegate {
    
}

extension ViewController: HWCollectionViewDatasource {
    func hwCollectionView(_ collectionView: HWCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func hwCollectionView(_ collectionView: HWCollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath)
        return cell
    }
}

extension ViewController: HWCollectionViewDelegateFlowLayout {
    func hwCollectionView(_ collectionView: HWCollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    func hwCollectionView(_ collectionView: HWCollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 50, left: 50, bottom: 50, right: 50)
    }
}


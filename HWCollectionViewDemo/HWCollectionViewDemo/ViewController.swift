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
    }

}

extension ViewController: HWCollectionViewDelegate {
    
}

extension ViewController: HWCollectionViewDatasource {
    func hwCollectionView(_ collectionView: HWCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func hwCollectionView(_ collectionView: HWCollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath)
        return cell
    }
    
    
}


//
//  ViewController.swift
//  LargeTitle
//
//  Created by hanwe lee on 2021/03/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "myTitle"
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let imageView = UIImageView(image: UIImage(systemName: "square.and.arrow.up.fill"))
        self.navigationController?.navigationBar.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: self.navigationController!.navigationBar.rightAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: self.navigationController!.navigationBar.bottomAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 30),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
            ])
        imageView.layer.zPosition = -1
    }

    @IBOutlet weak var tableView: UITableView!
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

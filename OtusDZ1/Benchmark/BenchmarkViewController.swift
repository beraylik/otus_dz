//
//  BenchmarkViewController.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 12/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

final class BenchmarkViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dataSource: [Algo] = Services.algoProvider.sortings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBehaviors(behaviors: [BenchmarkBehavior()])
        
         collectionView.register(BenchmarkCell.nib, forCellWithReuseIdentifier: BenchmarkCell.cellId)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(changeLayout))
    }

    @objc private func changeLayout() {
        print("Change layout")
        
        collectionView.setCollectionViewLayout(StagLayout(widthHeightRatios: [(1.0, 1.0), (0.5, 0.5), (0.5, 1.5), (0.5, 1.0)], itemSpacing: 4), animated: true)
    }
    
}

// MARK: - CollectionView DataSource

extension BenchmarkViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BenchmarkCell.cellId, for: indexPath) as? BenchmarkCell else {
            fatalError("Collection view Cell not found")
        }
        
        let algoItem = dataSource[indexPath.row]
        cell.update(name: algoItem.name, color: UIColor.random)
        
        return cell
    }
    
    
}

// MARK: - CollectionView Delegate

extension BenchmarkViewController: UICollectionViewDelegate {
    
}

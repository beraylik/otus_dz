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
    
    private let defaultLayouts: [UICollectionViewLayout] = [
        StagLayout(widthHeightRatios: [(1.0, 1.0), (0.5, 0.5), (0.5, 1.5), (0.5, 1.0)], itemSpacing: 4),
        StagLayout(widthHeightRatios: [(0.5, 0.5)], itemSpacing: 4),
        StagLayout(widthHeightRatios: [(0.5, 0.5)], itemSpacing: 4),
        StagLayout(widthHeightRatios: [(0.5, 0.5), (0.5, 1.5), (0.5, 1.0)], itemSpacing: 4)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBehaviors(behaviors: [BenchmarkBehavior()])
        
        collectionView.register(BenchmarkCell.nib, forCellWithReuseIdentifier: BenchmarkCell.cellId)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(changeLayout))
        
        changeLayout()
    }

    @objc private func changeLayout() {
        print("Change layout")
        
        if let layout = defaultLayouts.randomElement() {
            collectionView.setCollectionViewLayout(layout, animated: true)
        }
    }
    
    func invalidateTimers() {
        collectionView.reloadData()
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
        cell.update(algo: algoItem)
        
        
        return cell
    }
    
    
}

// MARK: - CollectionView Delegate

extension BenchmarkViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? BenchmarkCell else {
            fatalError("Collection view Cell not found")
        }
        cell.toggleTimer()
    }
    
}

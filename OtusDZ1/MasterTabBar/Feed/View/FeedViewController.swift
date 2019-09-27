//
//  FeedViewController.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 12/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit
import TestProfiler

class FeedViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    private var viewModel: FeedViewModel
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let dataProvider: FeedDataProvider? = ServiceLocator.shared.getService()
        self.viewModel = FeedViewModel(feedProvider: dataProvider!)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        let dataProvider: FeedDataProvider? = ServiceLocator.shared.getService()
        self.viewModel = FeedViewModel(feedProvider: dataProvider!)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        viewModel.testsCompletion = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func setupNavBar() {
        let testButton = UIBarButtonItem(title: "Run tests", style: .plain, target: self, action: #selector(runDefaultTests))
        navigationItem.rightBarButtonItem = testButton
    }
    
    @objc private func runDefaultTests() {
        viewModel.runTests()
    }
}

// MARK: - TableView DataSource

extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = viewModel.dataSource[indexPath.row].name
        cell.detailTextLabel?.text = viewModel.dataSource[indexPath.row].subtitle
        return cell
    }
    
}

// MARK: - TableView Delegate

extension FeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var vc: UIViewController?
        
        if let currentCell = tableView.cellForRow(at: indexPath), let name = currentCell.textLabel?.text {
            switch name {
            case "Array":
                let storyboard = UIStoryboard(name: "DataStructures", bundle: nil)
                vc = storyboard.instantiateViewController(withIdentifier: "ArrayViewController")
            case "Set":
                let storyboard = UIStoryboard(name: "DataStructures", bundle: nil)
                vc = storyboard.instantiateViewController(withIdentifier: "SetViewController")
            case "Dictionary":
                let storyboard = UIStoryboard(name: "DataStructures", bundle: nil)
                vc = storyboard.instantiateViewController(withIdentifier: "DictionaryViewController")
            case "SuffixArray":
                let storyboard = UIStoryboard(name: "DataStructures", bundle: nil)
                vc = storyboard.instantiateViewController(withIdentifier: "SuffixSequenceViewController")
            default:
                vc = SessionSummaryViewController()
            }
        }
        
        
        if let pushViewController = vc {
            self.navigationController?.pushViewController(pushViewController, animated: true)
        }
    }
    
}

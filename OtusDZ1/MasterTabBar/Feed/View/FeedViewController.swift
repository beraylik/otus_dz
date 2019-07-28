//
//  FeedViewController.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 12/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    private var viewModel: FeedViewModel = FeedViewModel()
    
    private var jsonPlaceholerProvider = Services.jsonProvider
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        jsonPlaceholerProvider.fetch(url: "/todos") { (result: Result<[Placeholder], Error>) in
            
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let responses):
                for tuple in responses.enumerated() {
                    print("\(tuple.offset): \(tuple.element.title)")
                }
            }
            
        }
    }

}

// MARK: - TableView DataSource

extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.cellId, for: indexPath)
        
        cell.textLabel?.text = viewModel.dataSource[indexPath.row].name
        
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

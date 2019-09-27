//
//  ScrollTaskVC.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 27/09/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit
import RealmSwift

// MARK: - Realm Placeholder model

final class RPlaceholder: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var userId = 0
    @objc dynamic var title = ""
    @objc dynamic var completed = false
    
    // MARK: - Initialization
    
    convenience required init(_ placeholder: Placeholder) {
        self.init()
        self.id = placeholder.id
        self.userId = placeholder.userId
        self.title = placeholder.title
        self.completed = placeholder.completed
    }
    
    func toJson() -> Placeholder {
        return Placeholder.init(userId: userId,
                                id: id,
                                title: title,
                                completed: completed)
    }
    
}

// MARK: - ScrollTask ViewController

final class ScrollTaskVC: UITableViewController {
    
    // MARK: - Properties
    
    private var todos: [Placeholder] = []
    private var realm = try? Realm()
    
    private let jsonPlaceholerProvider: JsonPlaceholderProvider = {
        if let service: JsonPlaceholderProvider = ServiceLocator.shared.getService() {
            return service
        } else {
            return JsonPlaceholderProvider()
        }
    }()
    
    // MARK: - ViewControllrt Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        jsonPlaceholerProvider.fetch(url: "/todos") { (result: Result<[Placeholder], Error>) in
            
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.loadSavedData()
            case .success(let responses):
                self.handleNewData(responses)
            }
            
        }
    }
    
    // MARK: - Interactions
    
    private func handleNewData(_ data: [Placeholder]) {
        DispatchQueue.main.async {
            self.todos = data
            self.tableView.reloadData()
            
            guard let realm = self.realm else { return }
            let newTodos = data.map({ RPlaceholder($0) })
            let stored = realm.objects(RPlaceholder.self)
            try? realm.write {
                realm.delete(stored)
                realm.add(newTodos)
                try? realm.commitWrite()
            }
        }
    }
    
    private func loadSavedData() {
        DispatchQueue.main.async {
            guard let realm = self.realm else { return }
            let storedData = realm.objects(RPlaceholder.self)
            let tableData: [Placeholder] = storedData.map({ $0.toJson() }).reversed()
            
            self.todos = tableData
            self.tableView.reloadData()
        }
    }
    
    // MARK: - TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let task = todos[indexPath.row]
        cell.textLabel?.text = "\(task.id): \(task.title)"
        return cell
    }
    
}


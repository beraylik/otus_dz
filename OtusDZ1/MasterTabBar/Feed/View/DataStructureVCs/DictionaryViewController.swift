//
//  DictionaryViewController.swift
//  DataStructures
//
//  Created by Ellen Shapiro on 8/2/14.
//  Copyright (c) 2014 Ray Wenderlich Tutorial Team. All rights reserved.
//

import UIKit
import TestProfiler

private enum DictionaryVCRow: Int {
  case creation = 0,
  add1Entry,
  add5Entries,
  add10Entries,
  remove1Entry,
  remove5Entries,
  remove10Entries,
  lookup1Entry,
  lookup10Entries
}

class DictionaryViewController: DataStructuresViewController {

  //MARK: - Variables

  let dictionaryManipulator: DictionaryManipulator = SwiftDictionaryManipulator()

    var storage: Storage? = nil
    
    var testResults = DictionaryTestModel()

  //MARK: - Methods

  //MARK: View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    createAndTestButton.setTitle("Create Dictionary and Test", for: UIControl.State())
  
    // set storage
    self.storage = ServiceLocator.shared.getService()
    
    // Load history
    if let model = storage?.retrieve("dictionary", from: .documents, as: DictionaryTestModel.self) {
        testResults = model
    }
  }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidLoad()
        // Save history
        storage?.store(testResults, to: .documents, as: "dictionary")
    }

  //MARK: Superclass creation/testing overrides

  override func create(_ size: Int) {
    testResults.creationTime = dictionaryManipulator.setupWithEntryCount(size)
  }

  override func test() {
    if dictionaryManipulator.dictHasEntries() {
      testResults.add1EntryTime = dictionaryManipulator.add1Entry()
      testResults.add5EntriesTime = dictionaryManipulator.add5Entries()
      testResults.add10EntriesTime = dictionaryManipulator.add10Entries()
      testResults.remove1EntryTime = dictionaryManipulator.remove1Entry()
      testResults.remove5EntriesTime = dictionaryManipulator.remove5Entries()
      testResults.remove10EntriesTime = dictionaryManipulator.remove10Entries()
      testResults.lookup1EntryTime = dictionaryManipulator.lookup1EntryTime()
      testResults.lookup10EntriesTime = dictionaryManipulator.lookup10EntriesTime()
    } else {
      print("Dictionary not yet set up!")
    }
  }

  //MARK: Table View Override

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = super.tableView(tableView, cellForRowAt: indexPath)

    switch (indexPath as NSIndexPath).row {
    case DictionaryVCRow.creation.rawValue:
      cell.textLabel!.text = "Dictionary Creation:"
      cell.detailTextLabel!.text = formattedTime(testResults.creationTime)
    case DictionaryVCRow.add1Entry.rawValue:
      cell.textLabel!.text = "Add 1 Entry:"
      cell.detailTextLabel!.text = formattedTime(testResults.add1EntryTime)
    case DictionaryVCRow.add5Entries.rawValue:
      cell.textLabel!.text = "Add 5 Entries:"
      cell.detailTextLabel!.text = formattedTime(testResults.add5EntriesTime)
    case DictionaryVCRow.add10Entries.rawValue:
      cell.textLabel!.text = "Add 10 Entries:"
      cell.detailTextLabel!.text = formattedTime(testResults.add10EntriesTime)
    case DictionaryVCRow.remove1Entry.rawValue:
      cell.textLabel!.text = "Remove 1 Entry:"
      cell.detailTextLabel!.text = formattedTime(testResults.remove1EntryTime)
    case DictionaryVCRow.remove5Entries.rawValue:
      cell.textLabel!.text = "Remove 5 Entries:"
      cell.detailTextLabel!.text = formattedTime(testResults.remove5EntriesTime)
    case DictionaryVCRow.remove10Entries.rawValue:
      cell.textLabel!.text = "Remove 10 Entries:"
      cell.detailTextLabel!.text = formattedTime(testResults.remove10EntriesTime)
    case DictionaryVCRow.lookup1Entry.rawValue:
      cell.textLabel!.text = "Lookup 1 Entry:"
      cell.detailTextLabel!.text = formattedTime(testResults.lookup1EntryTime)
    case DictionaryVCRow.lookup10Entries.rawValue:
      cell.textLabel!.text = "Lookup 10 Entries:"
      cell.detailTextLabel!.text = formattedTime(testResults.lookup10EntriesTime)
    default:
      print("Unhandled row! \((indexPath as NSIndexPath).row)")
    }

    return cell
  }
}

//
//  ArrayViewController.swift
//  DataStructures
//
//  Created by Ellen Shapiro on 8/2/14.
//  Copyright (c) 2014 Ray Wenderlich Tutorial Team. All rights reserved.
//

private enum ArrayVCRow: Int {
  case creation = 0,
  insertAt0,
  insertAtMid,
  insertAtEnd,
  deleteAt0,
  deleteAtMid,
  deleteAtEnd,
  lookupByIndex,
  lookupByObject
}

import UIKit
import TestProfiler

class ArrayViewController: DataStructuresViewController {

  //MARK: - Variables

  let arrayManipulator: ArrayManipulator = SwiftArrayManipulator()
    var storage: Storage? = nil
    
    var testResults = ArrayTestModel()
    
  //MARK: View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    createAndTestButton.setTitle("Create Array and Test", for: [])
    
    // set storage
    self.storage = ServiceLocator.shared.getService()
    
    // Load history
    if let model = storage?.retrieve("array", from: .documents, as: ArrayTestModel.self) {
        testResults = model
    }
  }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidLoad()
        // Save history
        storage?.store(testResults, to: .documents, as: "array")
    }
    
  //MARK: Superclass creation/testing overrides

  override func create(_ size: Int) {
    testResults.creationTime = arrayManipulator.setupWithObjectCount(size)
  }

  override func test() {
    if (arrayManipulator.arrayHasObjects()) {
      testResults.insertAt0Time = arrayManipulator.insertNewObjectAtBeginning()
      testResults.insertAtMidTime = arrayManipulator.insertNewObjectInMiddle()
      testResults.insertAtEndTime = arrayManipulator.addNewObjectAtEnd()
      testResults.removeAt0Time = arrayManipulator.removeFirstObject()
      testResults.removeAtMidTime = arrayManipulator.removeMiddleObject()
      testResults.removeAtEndTime = arrayManipulator.removeLastObject()
      testResults.lookupByIndexTime = arrayManipulator.lookupByIndex()
      testResults.lookupByObjectTime = arrayManipulator.lookupByObject()
    } else {
      print("Array not set up yet!")
    }
  }

  //MARK: Table View Override

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = super.tableView(tableView, cellForRowAt: indexPath)
    switch (indexPath as NSIndexPath).row {
    case ArrayVCRow.creation.rawValue:
      cell.textLabel!.text = "Array Creation:"
      cell.detailTextLabel!.text = formattedTime(testResults.creationTime)
    case ArrayVCRow.insertAt0.rawValue:
      cell.textLabel!.text = "Insert At Index 0:"
      cell.detailTextLabel!.text = formattedTime(testResults.insertAt0Time)
    case ArrayVCRow.insertAtMid.rawValue:
      cell.textLabel!.text = "Insert In Middle:"
      cell.detailTextLabel!.text = formattedTime(testResults.insertAtMidTime)
    case ArrayVCRow.insertAtEnd.rawValue:
      cell.textLabel!.text = "Insert At End:"
      cell.detailTextLabel!.text = formattedTime(testResults.insertAtEndTime)
    case ArrayVCRow.deleteAt0.rawValue:
      cell.textLabel!.text = "Remove From Index 0:"
      cell.detailTextLabel!.text = formattedTime(testResults.removeAt0Time)
    case ArrayVCRow.deleteAtMid.rawValue:
      cell.textLabel!.text = "Remove From Middle:"
      cell.detailTextLabel!.text = formattedTime(testResults.removeAtMidTime)
    case ArrayVCRow.deleteAtEnd.rawValue:
      cell.textLabel!.text = "Remove From End:"
      cell.detailTextLabel!.text = formattedTime(testResults.removeAtEndTime)
    case ArrayVCRow.lookupByIndex.rawValue:
      cell.textLabel!.text = "Lookup By Index:"
      cell.detailTextLabel!.text = formattedTime(testResults.lookupByIndexTime)
    case ArrayVCRow.lookupByObject.rawValue:
      cell.textLabel!.text = "Lookup By Object:"
      cell.detailTextLabel!.text = formattedTime(testResults.lookupByObjectTime)
    default:
      print("Unhandled row! \((indexPath as NSIndexPath).row)")
    }

    return cell
  }
}

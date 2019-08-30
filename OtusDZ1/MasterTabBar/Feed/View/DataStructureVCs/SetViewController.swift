//
//  SetViewController.swift
//  DataStructures
//
//  Created by Ellen Shapiro on 8/2/14.
//  Copyright (c) 2014 Ray Wenderlich Tutorial Team. All rights reserved.
//

import UIKit
import TestProfiler

private enum SetVCRow: Int {
  case creation = 0,
  add1Object,
  add5Objects,
  add10Objects,
  remove1Object,
  remove5Objects,
  remove10Objects,
  lookup1Object,
  lookup10Objects
}

class SetViewController: DataStructuresViewController {

  //MARK: - Variables

  let setManipulator = SwiftSetManipulator()

    var storage: Storage? = nil
    
    var testResults = SetTestModel()

  //MARK: - Methods

  //MARK: View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    createAndTestButton.setTitle("Create Set and Test", for: UIControl.State())
    // set storage
    self.storage = ServiceLocator.shared.getService()
    
    // Load history
    if let model = storage?.retrieve("set", from: .documents, as: SetTestModel.self) {
        testResults = model
    }
  }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidLoad()
        // Save history
        storage?.store(testResults, to: .documents, as: "set")
    }

  //MARK: Superclass creation/testing overrides

  override func create(_ size: Int) {
    testResults.creationTime = setManipulator.setupWithObjectCount(size)
  }

  override func test() {
    if (setManipulator.setHasObjects()) {
      testResults.add1ObjectTime = setManipulator.add1Object()
      testResults.add5ObjectsTime = setManipulator.add5Objects()
      testResults.add10ObjectsTime = setManipulator.add10Objects()
      testResults.remove1ObjectTime = setManipulator.remove1Object()
      testResults.remove5ObjectsTime = setManipulator.remove5Objects()
      testResults.remove10ObjectsTime = setManipulator.remove10Objects()
      testResults.lookup1ObjectTime = setManipulator.lookup1Object()
      testResults.lookup10ObjectsTime = setManipulator.lookup10Objects()
    } else {
      print("Set is not set up yet!")
    }
  }

  //MARK: Table View Override

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = super.tableView(tableView, cellForRowAt: indexPath)

    switch (indexPath as NSIndexPath).row {
    case SetVCRow.creation.rawValue:
      cell.textLabel!.text = "Set Creation:"
      cell.detailTextLabel!.text = formattedTime(testResults.creationTime)
    case SetVCRow.add1Object.rawValue:
      cell.textLabel!.text = "Add 1 Object:"
      cell.detailTextLabel!.text = formattedTime(testResults.add1ObjectTime)
    case SetVCRow.add5Objects.rawValue:
      cell.textLabel!.text = "Add 5 Objects:"
      cell.detailTextLabel!.text = formattedTime(testResults.add5ObjectsTime)
    case SetVCRow.add10Objects.rawValue:
      cell.textLabel!.text = "Add 10 Objects:"
      cell.detailTextLabel!.text = formattedTime(testResults.add10ObjectsTime)
    case SetVCRow.remove1Object.rawValue:
      cell.textLabel!.text = "Remove 1 Object:"
      cell.detailTextLabel!.text = formattedTime(testResults.remove1ObjectTime)
    case SetVCRow.remove5Objects.rawValue:
      cell.textLabel!.text = "Remove 5 Objects:"
      cell.detailTextLabel!.text = formattedTime(testResults.remove5ObjectsTime)
    case SetVCRow.remove10Objects.rawValue:
      cell.textLabel!.text = "Remove 10 Objects:"
      cell.detailTextLabel!.text = formattedTime(testResults.remove10ObjectsTime)
    case SetVCRow.lookup1Object.rawValue:
      cell.textLabel!.text = "Lookup 1 Object:"
      cell.detailTextLabel!.text = formattedTime(testResults.lookup1ObjectTime)
    case SetVCRow.lookup10Objects.rawValue:
      cell.textLabel!.text = "Lookup 10 Objects:"
      cell.detailTextLabel!.text = formattedTime(testResults.lookup10ObjectsTime)
    default:
      print("Unhandled row! \((indexPath as NSIndexPath).row)")
    }

    return cell
  }
}

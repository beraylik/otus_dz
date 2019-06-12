//
//  ProfileViewController.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 12/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

// MARK: - Behavior

final class ProfileBehavior: ViewControllerLifecycleBehavior {

    private var delegate: ProfileProtocol
    
    init(delegate: ProfileProtocol) {
        self.delegate = delegate
    }
    
    // MARK: - Life cycle
    
    func beforeAppearing(_ viewController: UIViewController) {
        delegate.setStatusBarStyle(style: .default)
        viewController.view.backgroundColor = .black
        viewController.navigationController?.navigationBar.backgroundColor = .black
    }
    
    func afterDisappearing(_ viewController: UIViewController) {
        delegate.setStatusBarStyle(style: .lightContent)
        viewController.navigationController?.navigationBar.backgroundColor = .white
    }
    
}

// MARK: - Protocol

protocol ProfileProtocol {
    func setStatusBarStyle(style: UIStatusBarStyle)
}

// MARK: - View Controller

final class ProfileViewController: UIViewController, ProfileProtocol {
    
    private var darkStatusBar: UIStatusBarStyle = .default
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBehaviors(behaviors: [ProfileBehavior(delegate: self)])
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return darkStatusBar
    }
    
    // MARK: - Protocol conformation
    
    func setStatusBarStyle(style: UIStatusBarStyle) {
        darkStatusBar = style
        setNeedsStatusBarAppearanceUpdate()
    }
    
}

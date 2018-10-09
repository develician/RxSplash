//
//  BaseViewController.swift
//  RxSplash
//
//  Created by killi8n on 30/09/2018.
//  Copyright © 2018 killi8n. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    
    // MARK: Initializing
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    
    // MARK: Rx
    var disposeBag = DisposeBag()
    
    
    // MARK: Layout Constraints
    private(set) var didSetupConstraints = false
    
    override func viewDidLoad() {
        self.view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.setupConstraints()
            self.didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    func setupConstraints() {
        // Override point
    }
    
    
}

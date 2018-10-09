//
//  BaseCollectionViewCell.swift
//  RxSplash
//
//  Created by killi8n on 05/10/2018.
//  Copyright © 2018 killi8n. All rights reserved.
//

import UIKit

import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    var disposeBag: DisposeBag = DisposeBag()
    
    
    // MARK: Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize() {
        // Override point
    }
    
}

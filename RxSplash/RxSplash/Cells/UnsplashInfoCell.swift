//
//  UnsplashInfoCell.swift
//  RxSplash
//
//  Created by killi8n on 06/10/2018.
//  Copyright © 2018 killi8n. All rights reserved.
//

import UIKit
import ReactorKit
import SnapKit
import Then

class UnsplashInfoCell: BaseCollectionViewCell, View {
    typealias Reactor = UnsplashInfoCellReactor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
    }
    
    func bind(reactor: Reactor) {
        
    }
    
    
}

//
//  ImageCell.swift
//  RxSplash
//
//  Created by killi8n on 04/10/2018.
//  Copyright © 2018 killi8n. All rights reserved.
//

import UIKit
import SnapKit
import Then
import ReactorKit


class ImageCell: BaseCollectionViewCell, View {
    typealias Reactor = ImageCellReactor
    
    let unsplashImageView = UIImageView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(self.unsplashImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.unsplashImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    func bind(reactor: Reactor) {
        let unsplash = reactor.currentState
        let imageUrl = unsplash.urls.regular
        guard let url = URL(string: imageUrl) else { return }
        self.unsplashImageView.kf.setImage(with: url)
    }
    
    
}

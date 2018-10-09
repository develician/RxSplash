//
//  InfoCell.swift
//  RxSplash
//
//  Created by killi8n on 05/10/2018.
//  Copyright © 2018 killi8n. All rights reserved.
//

import UIKit
import ReactorKit
import SnapKit
import Then
import CGFloatLiteral

class UserInfoCell: BaseCollectionViewCell, View {
    typealias Reactor = UserInfoCellReactor
    
    struct Metric {
        static let profileImageViewSize = 100.f
        static let profileImageViewPadding = 10.f
        static let nameLabelHeight = 40.f
    }
    
    struct Font {
        static let usernameLabel = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        static let nameLabel = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.regular)
    }
    
    let profileImageView = UIImageView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = Metric.profileImageViewSize / 2
    }
    
    let usernameLabel = UILabel().then {
        $0.font = Font.usernameLabel
    }
    
    let nameLabel = UILabel().then {
        $0.font = Font.nameLabel
    }
    
    let unsplashInfoTextView = UITextView().then {
        $0.backgroundColor = .blue
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(profileImageView)
        
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(usernameLabel)
        self.contentView.addSubview(unsplashInfoTextView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.profileImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Metric.profileImageViewPadding)
            make.left.equalToSuperview().offset(Metric.profileImageViewPadding)
            make.width.equalTo(Metric.profileImageViewSize)
            make.height.equalTo(Metric.profileImageViewSize)
        }
        
        self.nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.profileImageView.centerX).offset(8)
            make.left.equalTo(self.profileImageView.right).offset(8 + Metric.profileImageViewPadding + Metric.profileImageViewSize)
            make.height.equalTo(Metric.nameLabelHeight)
        }
        
        self.usernameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameLabel.top).offset(Metric.nameLabelHeight + 8)
            make.left.equalTo(self.profileImageView.right).offset(8 + Metric.profileImageViewPadding + Metric.profileImageViewSize)
        }
        
        self.unsplashInfoTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self.profileImageView.top).offset(Metric.profileImageViewPadding + Metric.profileImageViewSize + 16)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        
    }
    
    func bind(reactor: Reactor) {
        let name = reactor.currentState.name
        let profileImage = reactor.currentState.profileImage
        let username = reactor.currentState.username
        let profileImageUrl = profileImage.medium
        
        guard let url = URL(string: profileImageUrl) else { return }
        
        self.profileImageView.kf.setImage(with: url)
        
        self.nameLabel.text = name
        self.usernameLabel.text = username
        
    }
    
    
}

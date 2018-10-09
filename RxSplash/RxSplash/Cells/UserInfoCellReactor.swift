//
//  InfoCellReactor.swift
//  RxSplash
//
//  Created by killi8n on 05/10/2018.
//  Copyright © 2018 killi8n. All rights reserved.
//

import ReactorKit
import RxSwift
import RxCocoa

class UserInfoCellReactor: Reactor {
    typealias Action = NoAction
    
    let initialState: User
    
    init(user: User) {
        self.initialState = user
    }
    
    
}

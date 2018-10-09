//
//  ImageCellReactor.swift
//  RxSplash
//
//  Created by killi8n on 05/10/2018.
//  Copyright © 2018 killi8n. All rights reserved.
//

import ReactorKit

class ImageCellReactor: Reactor {
    typealias Action = NoAction
    
    let initialState: Unsplash
    
    init(unsplash: Unsplash) {
        self.initialState = unsplash
    }
    
    
}

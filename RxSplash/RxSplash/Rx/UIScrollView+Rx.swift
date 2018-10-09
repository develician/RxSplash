//
//  UIScrollView+Rx.swift
//  RxSplash
//
//  Created by killi8n on 05/10/2018.
//  Copyright © 2018 killi8n. All rights reserved.
//

import RxCocoa
import RxSwift

extension Reactive where Base: UIScrollView {
    
    var isReachedBottom: ControlEvent<Void> {
        let source = self.contentOffset
            .filter { [weak base = self.base] offset in
                guard let base = base else { return false }
                return base.isReachedBottom(withTolerance: base.height / 2)
            }
            .map { _ in Void() }
        return ControlEvent(events: source)
    }
    
}

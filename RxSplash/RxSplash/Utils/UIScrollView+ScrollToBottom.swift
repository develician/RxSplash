//
//  UIScrollView+ScrollToBottom.swift
//  RxSplash
//
//  Created by killi8n on 05/10/2018.
//  Copyright © 2018 killi8n. All rights reserved.
//

import UIKit
import ManualLayout

extension UIScrollView {
    
    var isOverflowVertical: Bool {
        return self.contentSize.height > self.height && self.height > 0
    }
    
    func isReachedBottom(withTolerance tolerance: CGFloat = 0) -> Bool {
        guard self.isOverflowVertical else { return false }
        let contentOffsetBottom = self.contentOffset.y + self.height
        return contentOffsetBottom >= self.contentSize.height - tolerance
    }
    
    func scrollToBottom(animated: Bool) {
        guard self.isOverflowVertical else { return }
        let targetY = self.contentSize.height + self.contentInset.bottom - self.height
        let targetOffset = CGPoint(x: 0, y: targetY)
        self.setContentOffset(targetOffset, animated: true)
    }
    
}

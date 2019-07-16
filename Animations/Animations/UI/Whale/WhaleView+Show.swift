//
//  WhaleView+Show.swift
//  Animations
//
//  Created by Yanis Plumit on 30/06/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit

extension WhaleView {
    
    func show() {
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        
        self.frame = keyWindow.bounds
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.isUserInteractionEnabled = true
        keyWindow.addSubview(self)
        keyWindow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideWhaleViewAction)))
        self.isAnimated = true
    }
    
    @objc private func hideWhaleViewAction() {
        removeFromSuperview()
    }
    
}

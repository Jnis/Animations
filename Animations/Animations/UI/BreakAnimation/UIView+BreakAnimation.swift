//
//  UIView+BreakAnimation.swift
//  Animations
//
//  Created by Yanis Plumit on 30/06/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /**
     Remove view after 1.0 seconds. Do not use this view again.
     Save animator and check it for nil to avoid layouting/logic
    */
    func startBrakAnimation() -> UIDynamicAnimator {
        return self.startBrakAnimation(views: self.viewsToBreakAnimation(skipSelf: true))
    }
    
    func startBrakAnimation(views: [UIView]) -> UIDynamicAnimator {
        let animator = UIDynamicAnimator(referenceView: self)
        let gravityBehavior = UIGravityBehavior()
        gravityBehavior.magnitude = 5
        animator.addBehavior(gravityBehavior)
        
        for v in views {
            v.isHidden = false
            guard let snapView = v.snapshotView(afterScreenUpdates: true) else { continue }
            v.isHidden = true
            let containerView = UIView()
            containerView.backgroundColor = .clear
            containerView.frame = v.convert(v.bounds, to: self)
            self.addSubview(containerView)
            containerView.addSubview(snapView)
            
            gravityBehavior.addItem(containerView)
            
            let elasticityBehavior = UIDynamicItemBehavior(items: [containerView])
            let velocity = CGPoint(x: 400.0 * CGFloat.random(in: 0..<1), y: (-1300.0 * CGFloat.random(in: 0..<1)) - 300.0)
            elasticityBehavior.addLinearVelocity(velocity, for: containerView)
            elasticityBehavior.addAngularVelocity((2.0 * CGFloat.random(in: 0..<1) - 1.0), for: containerView)
            elasticityBehavior.elasticity = 0.7
            animator.addBehavior(elasticityBehavior)
        }
        return animator
    }
    
    func viewsToBreakAnimation(skipSelf: Bool = false) -> [UIView] {
        var result: [UIView] = []
        if !isHidden {
            if !skipSelf && (self.isKind(of: UIButton.self) || self.isKind(of: UIImageView.self) || self.isMember(of: UIView.self)) {
                result.append(self)
                self.isHidden = true
            }
            // Skip UIButton because it contains UIImageView
            if !self.isKind(of: UIButton.self) {
                for v in self.subviews {
                    result.append(contentsOf: v.viewsToBreakAnimation())
                }
            }
        }
        return result;
        
    }
}

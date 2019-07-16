//
//  BreakAnimationViewController.swift
//  Animations
//
//  Created by Yanis Plumit on 30/06/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit

class BreakAnimationViewController: UIViewController {
    
    private let didCloseAction: (_ vc: BreakAnimationViewController) -> Void
    
    init(didCloseAction: @escaping (_ vc: BreakAnimationViewController) -> Void) {
        self.didCloseAction = didCloseAction
        super.init(nibName: "BreakAnimationViewController", bundle: nil)
    }
    
    @IBOutlet weak var popupCenterYConstraint: NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupCenterYConstraint.constant -= UIScreen.main.bounds.height
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            self.popupCenterYConstraint.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    var animator: UIDynamicAnimator?
    
    @IBAction func closeAction(_ sender: UIButton) {
        self.view.isUserInteractionEnabled = false
        animator = self.view.startBrakAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.didCloseAction(self)
        })
    }
    
}

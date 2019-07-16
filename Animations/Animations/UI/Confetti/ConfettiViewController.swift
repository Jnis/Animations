//
//  ConfettiViewController.swift
//  Animations
//
//  Created by Yanis Plumit on 14/07/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit

class ConfettiViewController: UIViewController {
    
    private let selfView: UIView = {
        let v = UILabel()
        v.textColor = UIColor.black
        v.backgroundColor = UIColor(white: 0, alpha: 0.8)
        v.text = "🎉 🎉 🎉"
        v.textAlignment = .center
        v.isUserInteractionEnabled = true
        return v
    }()
    
    private let didCloseAction: (_ vc: ConfettiViewController) -> Void
    
    init(didCloseAction: @escaping (_ vc: ConfettiViewController) -> Void) {
        self.didCloseAction = didCloseAction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selfView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeAction)))
    }
    
    private var wasStartConfetti = false
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !wasStartConfetti {
            wasStartConfetti = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.selfView.showConfetti()
            })
        }
    }
    
    @objc func closeAction() {
        self.didCloseAction(self)
    }
    
}


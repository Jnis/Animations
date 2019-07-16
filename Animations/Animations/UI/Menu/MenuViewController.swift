//
//  MenuViewController.swift
//  Animations
//
//  Created by Yanis Plumit on 30/06/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController {
    
    private let selfView = MenuView()
    
    override func loadView() {
        self.view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Animations"
        navigationController?.navigationBar.isTranslucent = false
        reloadButtons()
    }
    
    private func reloadButtons() {
        selfView.buttonModels = [
            MenuView.ButtonModel(title: "Break animation", action: {[weak self] in
                let vc = BreakAnimationViewController(didCloseAction: { (vc) in
                    vc.dismiss(animated: true, completion: nil)
                })
                vc.modalPresentationStyle = .custom
                vc.modalTransitionStyle = .crossDissolve
                self?.present(vc, animated: true, completion: nil)
            }),
            MenuView.ButtonModel(title: "Whale Animation (PhotoLink app)", action: {
                WhaleView().show()
            }),
            MenuView.ButtonModel(title: "Confetti animation", action: {[weak self] in
                let vc = ConfettiViewController(didCloseAction: { (vc) in
                    vc.dismiss(animated: true, completion: nil)
                })
                vc.modalPresentationStyle = .custom
                vc.modalTransitionStyle = .crossDissolve
                self?.present(vc, animated: true, completion: nil)
            }),
        ]
    }
    
}

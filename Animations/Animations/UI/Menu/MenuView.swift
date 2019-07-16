//
//  MenuView.swift
//  Animations
//
//  Created by Yanis Plumit on 30/06/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit

extension MenuView {
    
    struct ButtonModel {
        let title: String
        let action: () -> Void
    }
    
}

class MenuView: UIView {
    
    var buttonModels: [ButtonModel] = [] {
        didSet {
            buttons.forEach { (button) in
                button.removeFromSuperview()
            }
            buttons = []
            
            for model in buttonModels {
                let v = UIButton()
                v.setTitle(model.title, for: .normal)
                v.setTitleColor(.black, for: .normal)
                v.setTitleColor(.red, for: .highlighted)
                v.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
                self.addSubview(v)
                buttons.append(v)
            }
            
            self.setNeedsLayout()
        }
    }
    
    private var buttons: [UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var y: CGFloat = 20
        
        for button in buttons {
            button.frame = {
                var rect = CGRect.zero
                rect.origin.x = 10
                rect.origin.y = y
                rect.size.width = self.bounds.width - rect.origin.x * 2
                rect.size.height = 44
                return rect
            }()
            y = button.frame.maxY + 10
        }
    }
    
    // MARK: Actions
    
    @objc private func buttonAction(button: UIButton) {
        if let index = self.buttons.firstIndex(of: button) {
            buttonModels[index].action()
        }
    }
    
}

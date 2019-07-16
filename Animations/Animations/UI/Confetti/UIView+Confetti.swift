//
//  UIView+Confetti.swift
//  Animations
//
//  Created by Yanis Plumit on 14/07/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    private func confetti(color: UIColor, imageNamed: String, birthRate: Float) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.name = String(format: "confetti_%@_%@", color.toHexString, imageNamed)
        cell.beginTime = Double.random(in: 0..<1)
        cell.birthRate = birthRate
        cell.lifetime = 7.0
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = 200
        cell.velocityRange = 50
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 2
        cell.spinRange = 3
        cell.scaleRange = 0.5
        cell.scaleSpeed = -0.05
        cell.contents = UIImage(named: imageNamed)?.cgImage
        return cell
    }
    
    private func createEmitter(birthRate: Float) -> CAEmitterLayer {
        let emitter = CAEmitterLayer()
        emitter.birthRate = birthRate
        emitter.beginTime = CACurrentMediaTime()
        emitter.emitterPosition = CGPoint(x: self.center.x, y: -96)
        emitter.emitterShape = CAEmitterLayerEmitterShape.line
        emitter.emitterSize = CGSize(width: self.frame.size.width, height: 1)
        return emitter
    }
    
    func showConfetti() {
        let emitter = self.createEmitter(birthRate: 3)
        emitter.emitterCells = {
            var cells: [CAEmitterCell] = []
            for imageName in ["c_circle", "c_square", "c_pentagon", "c_triangle"] {
                for color in [UIColor(hex: "#29cdff"), UIColor(hex: "#78ff44"), UIColor(hex: "#ff718d"), UIColor(hex: "#fdff6a")] {
                    cells.append(self.confetti(color: color, imageNamed: imageName, birthRate: 3))
                }
            }
            return cells
        }()
        self.layer.addSublayer(emitter)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
            emitter.birthRate = 0
        })
        
        let emitter2 = self.createEmitter(birthRate: 1)
        emitter2.emitterCells = [self.confetti(color: UIColor(hex: "#fdff6a"), imageNamed: "c_pentagon", birthRate: 1),
                                 self.confetti(color: UIColor(hex: "#29cdff"), imageNamed: "c_triangle", birthRate: 1)]
        self.layer.addSublayer(emitter2)
    }
}

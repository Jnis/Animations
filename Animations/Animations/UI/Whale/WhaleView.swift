//
//  WhaleView.swift
//  Animations
//
//  Created by Yanis Plumit on 30/06/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit

class WhaleView: UIView {
    
    var isAnimated: Bool = false {
        didSet {
            if oldValue != isAnimated {
                self.resetAnimation()
            }
        }
    }
    
    private var isReset = false
    private var failAnimationCount = 0
    
    // MARK: Views
    
    private let whaleImageView = UIImageView(image: UIImage(named: "whale"))
    private let whaleEyeImageView = UIImageView(image: UIImage(named: "whale_eye"))
    private let whaleWaterImageView: UIImageView = {
        let img1 = UIImage(named: "whale_water1")!
        let img2 = UIImage(named: "whale_water2")!
        let v = UIImageView(frame: CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
        v.animationImages = [img1, img2, img1, img2, img1]
        v.animationDuration = 2
        v.animationRepeatCount = 0
        return v
    }()
    private let whaleWavesImageView = UIImageView(image: UIImage(named: "whale_waves"))
    
    // MARK:
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.addSubview(whaleImageView)
        whaleImageView.addSubview(whaleEyeImageView)
        whaleImageView.addSubview(whaleWaterImageView)
        self.addSubview(whaleWavesImageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func resetAnimation() {
        
        CATransaction.begin()
        layer.removeAllAnimations()
        whaleImageView.layer.removeAllAnimations()
        whaleEyeImageView.layer.removeAllAnimations()
        whaleWaterImageView.layer.removeAllAnimations()
        whaleWavesImageView.layer.removeAllAnimations()
        CATransaction.commit()
        CATransaction.flush()
        
        // Reset
        let whaleAngleDif: CGFloat = 0.1
        let whaleCenterStart = CGPoint(x: bounds.width * 0.5 + 10, y: bounds.height * 0.5 - 5)
        let whaleCenterEnd = CGPoint(x: whaleCenterStart.x, y: whaleCenterStart.y + 10)
        
        whaleImageView.transform = CGAffineTransform(rotationAngle: -whaleAngleDif)
        whaleImageView.center = whaleCenterStart
        
        whaleEyeImageView.center = CGPoint(x: whaleImageView.bounds.width * 0.18, y: whaleImageView.bounds.height * 0.45)
        whaleEyeImageView.transform = .identity
        
        let waterSize = whaleWaterImageView.bounds.size
        whaleWaterImageView.frame = CGRect(x: whaleImageView.bounds.width * 0.18, y: -waterSize.height, width: waterSize.width, height: waterSize.height)
        whaleWaterImageView.stopAnimating()
        
        let waveXdif: CGFloat = 20
        let waveCenterStart = CGPoint(x: bounds.size.width * 0.5 - waveXdif, y: bounds.size.height * 0.5 + whaleWavesImageView.bounds.height + 10)
        let waveCenterEnd = CGPoint(x: waveCenterStart.x + waveXdif * 2, y: waveCenterStart.y + 10)
        self.whaleWavesImageView.transform = .identity
        self.whaleWavesImageView.center = waveCenterStart
        
        if !self.isAnimated || self.isReset {
            return
        }
        
        // Animate
        
        let completion: (_ finished: Bool) -> Void = {[weak self] finished in
            guard let self = self else {
                return
            }
            // avoid stops when user minimize app
            if !finished && !self.isReset {
                self.failAnimationCount += 1
                DispatchQueue.main.async {
                    self.failAnimationCount -= 1
                    if 0 == self.failAnimationCount {
                        if nil == self.window {
                            self.isAnimated = false
                        }
                        self.isReset = true
                        self.resetAnimation()
                        DispatchQueue.main.async {
                            self.isReset = false
                            self.resetAnimation()
                        }
                    }
                }
            }
        }
        
        self.whaleWaterImageView.startAnimating()
        
        UIView.animate(withDuration: 2.0, delay: 1.0, options: [.autoreverse, .repeat, .curveEaseInOut], animations: {[weak self] in
            self?.whaleImageView.transform = CGAffineTransform(rotationAngle: whaleAngleDif)
        }, completion: { finished in
            completion(finished)
        })
        
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [.autoreverse, .repeat, .curveEaseInOut], animations: {[weak self] in
            self?.whaleImageView.center = whaleCenterEnd
            }, completion: { finished in
                completion(finished)
        })
        
        UIView.animateKeyframes(withDuration: 3.0, delay: 3.0, options: [.repeat], animations: {[weak self] in
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.1, animations: {[weak self] in
                self?.whaleEyeImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.1, animations: {[weak self] in
                self?.whaleEyeImageView.transform = CGAffineTransform(scaleX: 1, y: 0)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.1, animations: {[weak self] in
                self?.whaleEyeImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.1, animations: {[weak self] in
                self?.whaleEyeImageView.transform = CGAffineTransform(scaleX: 1, y: 0)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.1, animations: {[weak self] in
                self?.whaleEyeImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
            }, completion: { finished in
                completion(finished)
        })
        
        UIView.animate(withDuration: 3.0, delay: 0.0, options: [.autoreverse, .repeat, .curveEaseInOut], animations: {[weak self] in
            self?.whaleWavesImageView.transform = CGAffineTransform(translationX: 0, y: 5)
            }, completion: { finished in
                completion(finished)
        })
        
        UIView.animate(withDuration: 5.0, delay: 0.0, options: [.autoreverse, .repeat, .curveEaseInOut], animations: {[weak self] in
            self?.whaleWavesImageView.center = waveCenterEnd
            }, completion: { finished in
                completion(finished)
        })
    }
    
}

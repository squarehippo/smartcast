//
//  SnowParticle.swift
//  SmartCast
//
//  Created by Brian Wilson on 2/8/16.
//  Copyright © 2016 GetRunGo. All rights reserved.
//

import UIKit

class SnowParticle: UIView {
    
    let particleEmitter = CAEmitterLayer()

    func createParticles(thisView: UIView) {
        particleEmitter.emitterPosition = CGPoint(x: thisView.center.x, y: -96)
        particleEmitter.emitterShape = kCAEmitterLayerLine
        particleEmitter.emitterSize = CGSize(width: thisView.frame.size.width, height: 1)
        particleEmitter.emitterCells = [makeEmitterCellWithColor(UIColor.whiteColor())]
        
        thisView.layer.addSublayer(particleEmitter)
    }
    
    func makeEmitterCellWithColor(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.name = "emitterCell"
        cell.birthRate = 10
        cell.alphaSpeed = -0.05
        cell.alphaRange = 1.5
        cell.lifetime = 30.0
        cell.lifetimeRange = 0
        cell.color = color.CGColor
        cell.velocity = 50
        cell.velocityRange = 50
        cell.emissionLongitude = CGFloat(M_PI)
        cell.emissionRange = CGFloat(M_PI_4)
        cell.spin = -0.5
        cell.spinRange = 1.0
        cell.scale = 0.2
        cell.scaleRange = 0.2
        cell.scaleSpeed = 0
        
        cell.contents = UIImage(named: "snow-small")?.CGImage
        return cell
    }
    
    func startSnow(aView: UIView) {
        createParticles(aView)
    }
    
    func stopSnow() {
        particleEmitter.removeFromSuperlayer()
    }

}

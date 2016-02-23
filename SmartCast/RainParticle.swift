//
//  RainParticle.swift
//  SmartCast
//
//  Created by Brian Wilson on 2/8/16.
//  Copyright © 2016 GetRunGo. All rights reserved.
//

import UIKit

class RainParticle: UIView {
    
    let particleEmitter = CAEmitterLayer()

    func createParticles(thisView: UIView) {
        particleEmitter.emitterPosition = CGPoint(x: thisView.center.x, y: -96)
        particleEmitter.emitterShape = kCAEmitterLayerLine
        particleEmitter.emitterSize = CGSize(width: thisView.frame.size.width, height: 1)
        particleEmitter.emitterCells = [makeEmitterCellWithColor(UIColor.whiteColor().colorWithAlphaComponent(0.7))]
        
        thisView.layer.addSublayer(particleEmitter)
    }
    
    func makeEmitterCellWithColor(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 75
        cell.alphaSpeed = 0
        cell.alphaRange = 0.2
        cell.lifetime = 4.0
        cell.lifetimeRange = 0
        cell.color = color.CGColor
        cell.velocity = 400
        cell.velocityRange = 100
        cell.emissionLongitude = CGFloat(M_PI)
        cell.emissionRange = 0
        cell.spin = 0
        cell.spinRange = 0
        cell.scale = 0.05
        //cell.scaleRange = 0.05
        cell.scaleSpeed = 0
        
        cell.contents = UIImage(named: "spark")?.CGImage
        return cell
    }
    
    func startRain(aView: UIView) {
        createParticles(aView)
    }
    
    func stopRain() {
        particleEmitter.removeFromSuperlayer()
    }


}

//
//  CloudyParticle.swift
//  SmartCast
//
//  Created by Brian Wilson on 2/10/16.
//  Copyright © 2016 GetRunGo. All rights reserved.
//

import UIKit

class CloudyParticle: UIView {
    
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
        cell.birthRate = 45
        cell.alphaSpeed = -0.05
        cell.alphaRange = 10.0
        cell.lifetime = 100.0
        cell.lifetimeRange = 0
        cell.color = color.CGColor
        cell.velocity = 0.5
        cell.velocityRange = 10
        cell.emissionLongitude = CGFloat(M_PI)
        cell.emissionRange = 0
        cell.spin = 0
        cell.spinRange = 0
        cell.scale = 0.05
        cell.scaleRange = 0.05
        cell.scaleSpeed = 0
        
        cell.contents = UIImage(named: "cloudy")?.CGImage
        return cell
    }
    
    func startClouds(aView: UIView) {
        createParticles(aView)
    }
    
    func stopClouds() {
        particleEmitter.removeFromSuperlayer()
    }
    
}

//
//  MeteoritesResultTableView.swift
//  MeteoriteLanding
//
//  Created by Radim Langer on 09/04/2017.
//  Copyright © 2017 Radim Langer. All rights reserved.
//

import UIKit

class MeteoritesResultTableView: UITableView {

    let flyingMeteor1ImageView = UIImageView(image: #imageLiteral(resourceName: "flyingMeteor1"))
    let flyingMeteor2ImageView = UIImageView(image: #imageLiteral(resourceName: "flyingMeteor2"))
    let spaceImageView = UIImageView(image: #imageLiteral(resourceName: "planetSpace"))
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        spaceImageView.contentMode = .scaleAspectFill
        
        addMotionEffect(to: flyingMeteor1ImageView, horizontalRange: 50, verticalRange: 30)
        addMotionEffect(to: flyingMeteor2ImageView, horizontalRange: 30, verticalRange: 50)
        
        backgroundView = spaceImageView
        backgroundView?.addSubview(flyingMeteor1ImageView)
        backgroundView?.addSubview(flyingMeteor2ImageView)

        addBlurEffect()
        
        setLayoutForMeteorImages()
    }
    // didn't work with constrants
    private func setLayoutForMeteorImages() {
        guard   let image1Width = flyingMeteor1ImageView.image?.size.width,
                let image1Height = flyingMeteor1ImageView.image?.size.height,
                let image2Width = flyingMeteor2ImageView.image?.size.width,
                let image2Height = flyingMeteor2ImageView.image?.size.height
        else {
            return
        }
        
        flyingMeteor1ImageView.frame = CGRect(x: 20, y: 50, width: image1Width, height: image1Height)
        flyingMeteor2ImageView.frame = CGRect(x: 50, y: 300, width: image2Width, height: image2Height)
    }
    
    private func addMotionEffect(to view: UIView, horizontalRange: CGFloat, verticalRange: CGFloat) {
        
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -horizontalRange
        horizontalMotionEffect.maximumRelativeValue = horizontalRange
        
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -verticalRange
        verticalMotionEffect.maximumRelativeValue = verticalRange
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        
        view.addMotionEffect(motionEffectGroup)
    }
    
    private func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)
        
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.5
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = bounds
        backgroundView?.addSubview(blurEffectView)
    }
}

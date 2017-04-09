//
//  LaunchViewController.swift
//  MeteoriteLanding
//
//  Created by Radim Langer on 08/04/2017.
//  Copyright © 2017 Radim Langer. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    private let blueDarkColor = UIColor(colorLiteralRed: 19.0/255.0, green: 37.0/255.0, blue: 102.0/255.0, alpha: 1)
    private let curvePrimaryOffset: CGFloat = 100
    
    // MARK: life cycle
    
    override func loadView() {
        super.loadView()

        self.setGradientLayer(colors: [blueDarkColor, .black])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AppUtility.lockOrientation(.portrait)
        
        showResultsAfterAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppUtility.lockOrientation(.all)
    }

    // MARK: animation
    
    private func showResultsAfterAnimation() {
        
        // after we finish not delayed animation, then setCompletionBlock handler is called
        CATransaction.begin()
        
        CATransaction.setCompletionBlock {
            self.performSegue(withIdentifier: "launchScreenSegue", sender: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animateFallingStar(topOffset: 10, lineWidth: 2)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.animateFallingStar(topOffset: 50, lineWidth: 1)
        }
        
        animateFallingStar(topOffset: 0, lineWidth: 1)
        
        CATransaction.commit()
    }
    
    private func animateFallingStar(topOffset: CGFloat, lineWidth: CGFloat) {
        
        // creating metheorite path
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: curvePrimaryOffset + topOffset))
        
        let width = view.frame.size.width
        
        path.addQuadCurve(to: CGPoint(x: width, y: curvePrimaryOffset + topOffset), controlPoint: CGPoint(x: width/2, y: 5 + topOffset))
        
        let shapeLayer = CAShapeLayer()
        // putting it to it's start
        shapeLayer.strokeStart = 0.0
        
        shapeLayer.frame = view.frame
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        view.layer.addSublayer(shapeLayer)
        
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = lineWidth
        
        let meteoriteOnTheSkyAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        meteoriteOnTheSkyAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        meteoriteOnTheSkyAnimation.duration = 2.0
        meteoriteOnTheSkyAnimation.fromValue = 0.0
        meteoriteOnTheSkyAnimation.toValue = 1.0
        
        shapeLayer.add(meteoriteOnTheSkyAnimation, forKey: "strokeAnim")
    }
    
    // MARK: background
    
    private func setGradientLayer(colors: Array<UIColor>) {
     
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = colors.map( {($0.cgColor)} )
        
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
}

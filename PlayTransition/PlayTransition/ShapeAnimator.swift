//
//  ShapeAnimator.swift
//  PlayTransition
//
//  Created by 小白 on 2017/9/19.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

enum ShapeTransitionMode {
    case present
    case push
    case pop
}

class ShapeAnimator: NSObject {
    
    var animationDuration: TimeInterval = 2

    var viewCenter: CGPoint = .zero
    var viewSize: CGSize = .zero
    var startPoint: CGPoint = .zero
    
    var transitionMode: ShapeTransitionMode = .present
    
    var shapeView: UIView = UIView()
    
    convenience init(duration: TimeInterval, viewCenter: CGPoint, viewSize: CGSize, startPoint: CGPoint, transitionMode: ShapeTransitionMode) {
        self.init()
        self.viewCenter = viewCenter
        self.viewSize = viewSize
        self.startPoint = startPoint
        self.animationDuration = duration
        self.transitionMode = transitionMode
    }
}

extension ShapeAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        
        if transitionMode == .present || transitionMode == .push {
            let maskView = UIView()
            maskView.frame = frameForCircle(viewCenter: viewCenter, size: viewSize, startPoint: startPoint)
            maskView.backgroundColor = .blue
            maskView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            maskView.layer.cornerRadius = maskView.bounds.size.width / 2
            maskView.clipsToBounds = true
            maskView.center = startPoint
            toView?.alpha = 0
            
            containerView.addSubview(maskView)
            containerView.addSubview(toView!)
            
            let duration = self.transitionDuration(using: transitionContext)
            UIView.animate(withDuration: duration, animations: { [weak self] in
                maskView.transform = .identity
                toView?.alpha = 1
                maskView.center = self?.viewCenter ?? .zero
            }) { (success) in
                transitionContext.completeTransition(success)
            }
        } else if transitionMode == .pop {
            let maskView = UIView()
            maskView.frame = frameForCircle(viewCenter: viewCenter, size: viewSize, startPoint: startPoint)
            maskView.backgroundColor = .blue
            maskView.transform = CGAffineTransform(scaleX: 1, y: 1)
            maskView.layer.cornerRadius = maskView.bounds.size.width / 2
            maskView.clipsToBounds = true
            maskView.center = startPoint
            toView?.alpha = 0
            
            containerView.addSubview(maskView)
            containerView.addSubview(toView!)
            
            let duration = self.transitionDuration(using: transitionContext)
            UIView.animate(withDuration: duration, animations: { [weak self] in
                maskView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                toView?.alpha = 1
                maskView.center = (self?.viewCenter) ?? .zero
            }) { (success) in
                transitionContext.completeTransition(success)
            }
        }
        
    }
    
    func frameForCircle(viewCenter: CGPoint, size: CGSize, startPoint: CGPoint) -> CGRect {
        let xLength = fmax(viewCenter.x, size.width - startPoint.x)
        let yLength = fmax(viewCenter.y, size.height - startPoint.y)
        
        let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let returnSize = CGSize(width: offsetVector, height: offsetVector)
        
        return CGRect(origin: .zero, size: returnSize)
    }
    
}

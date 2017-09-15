//
//  SpringAnimator.swift
//  PlayTransition
//
//  Created by 小白 on 2017/9/15.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class SpringAnimator: NSObject {
    
    var animationDuration: TimeInterval = 2
    var initialVelocity: CGFloat = 0
    var springDamping: CGFloat = 0.4
    
    convenience init(duration: TimeInterval, velocity: CGFloat, damping: CGFloat) {
        self.init()
        animationDuration = duration
        initialVelocity = velocity
        springDamping = damping
    }
}

extension SpringAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let containerView = transitionContext.containerView
        
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        
        toView?.frame = fromView?.frame.offsetBy(dx: 0, dy: -(fromView?.frame.size.height ?? 0)) ?? .zero
        toView?.alpha = 0
        
        containerView.addSubview(toView!)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: initialVelocity, options: .curveLinear, animations: {
            toView!.alpha = 1.0
            toView?.frame = transitionContext.finalFrame(for: toViewController!)
        }) { (isFinished) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
}

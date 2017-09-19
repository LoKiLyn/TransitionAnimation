//
//  BlueViewController.swift
//  PlayTransition
//
//  Created by 小白 on 2017/9/19.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.delegate = self
    }
    
}

extension BlueViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            //            return SpringAnimator(duration: TimeInterval(animationDurationSlider.value), velocity: CGFloat(initialVelocitySlider.value), damping: CGFloat(springSlider.value))
            return ShapeAnimator(duration: 2, viewCenter: fromVC.view.center, viewSize: fromVC.view.bounds.size, startPoint: self.view.center, transitionMode: .pop)
        } else {
            return nil
        }
    }
}

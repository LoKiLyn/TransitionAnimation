//
//  ViewController.swift
//  PlayTransition
//
//  Created by 小白 on 2017/9/15.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class GreenViewController: UIViewController {

    @IBOutlet weak var initialVelocitySlider: UISlider!
    @IBOutlet weak var springSlider: UISlider!
    @IBOutlet weak var animationDurationSlider: UISlider!
    @IBOutlet weak var transitionButton: UIButton!
    
    var isAnimationSpring: Bool = true
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.delegate = self
    }
    
    @IBAction func jumpButtonPressed(sender: UIButton) {
        self.performSegue(withIdentifier: "showBlueVC", sender: self)
    }
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        isAnimationSpring = !isAnimationSpring
    }
}

extension GreenViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            if isAnimationSpring {
                return SpringAnimator(duration: TimeInterval(animationDurationSlider.value), velocity: CGFloat(initialVelocitySlider.value), damping: CGFloat(springSlider.value))
            } else {
                return ShapeAnimator(duration: TimeInterval(animationDurationSlider.value), viewCenter: fromVC.view.center, viewSize: fromVC.view.bounds.size, startPoint: self.transitionButton.center, transitionMode: .push)
            }
        } else {
            return nil
        }
    }
}


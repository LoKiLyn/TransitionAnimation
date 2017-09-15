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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
    }

    
    @IBAction func jumpButtonPressed(sender: UIButton) {
        self.performSegue(withIdentifier: "showBlueVC", sender: self)
    }
}

extension GreenViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return SpringAnimator(duration: TimeInterval(animationDurationSlider.value), velocity: CGFloat(initialVelocitySlider.value), damping: CGFloat(springSlider.value))
        } else {
            return nil
        }
    }
}


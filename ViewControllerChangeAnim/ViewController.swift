//
//  ViewController.swift
//  ViewControllerChangeAnim
//
//  Created by Murph Lu on 2017/5/11.
//  Copyright © 2017年 Murph Lu. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller =  AniTestViewController()
        if indexPath.row == 0 {
            
            controller.transitioningDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let aminator = MyAnimator(presenting: true)
        return aminator
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = MyAnimator(presenting: false)
        return animator
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            let aminator = MyAnimator(presenting: true)
            return aminator
        }else if operation == .pop{
            let aminator = MyAnimator(presenting: false)
            return aminator
        }
        return nil;
    }
    
    

}

class MyAnimator: NSObject, UIViewControllerAnimatedTransitioning{
    
    var presenting:Bool = true
    
    init(presenting: Bool) {
        super.init()
        self.presenting = presenting
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = transitionContext.view(forKey: .to)
        let fromView = transitionContext.view(forKey: .from)
        
        let containerFrame = containerView.frame
        var toViewStartFrame = transitionContext.initialFrame(for: toVC!)
        
        let toViewFinalFrame = transitionContext.finalFrame(for: toVC!)
        
        var fromViewFinalFrame = transitionContext.finalFrame(for: fromVC!)
        containerView.addSubview(toView!)
        if self.presenting{
            toViewStartFrame.origin.x = containerFrame.size.width
            toViewStartFrame.origin.y = containerFrame.size.height
            toView?.frame = toViewStartFrame
        }else{
            fromViewFinalFrame = CGRect.init(x: containerFrame.size.width, y: containerFrame.size.height, width:(toView?.frame.size.width)!, height:(toView?.frame.size.height)!);
            toView?.frame = toViewFinalFrame
            containerView.bringSubview(toFront: fromView!)
        }
        
        UIView.animate(withDuration: self.transitionDuration(using:transitionContext), animations: {
            if self.presenting{
                toView?.frame = toViewFinalFrame
            }else{
                
                fromView?.frame = fromViewFinalFrame
            }
        }) { (finshed) in
            
            let success = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(success)
        }
    }
    
    
}


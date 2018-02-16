//
//  animation.swift
//  youtubeSample2
//
//  Created by Rijutha Datla on 12/11/17.
//  Copyright © 2017 Rijutha. All rights reserved.
//

import Foundation
import UIKit
class PopAnimator: NSObject,  UIViewControllerAnimatedTransitioning  {
    
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    var dismissCompletion: (()->Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        
        let videoPlayerView = presenting ? toView : transitionContext.view(forKey: .from)!
        
        //        containerView.addSubview(toView)
        //        toView.alpha = 0.0
        //        UIView.animate(withDuration: duration,
        //                       animations: {
        //                        toView.alpha = 1.0
        //        },
        //                       completion: { _ in
        //                        transitionContext.completeTransition(true)
        //        }
        //        )
        
        let initialFrame = presenting ? originFrame : videoPlayerView.frame
        let finalFrame = presenting ? videoPlayerView.frame : originFrame
        
        let xScaleFactor = presenting ?
            initialFrame.width/finalFrame.width :
            finalFrame.width/initialFrame.width
        
        let yScaleFactor = presenting ?
            initialFrame.height/finalFrame.height :
            finalFrame.height/initialFrame.height
        
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting{
            videoPlayerView.transform = scaleTransform
           // videoPlayerView.center = CGPoint(x: videoPlayerView.frame.midX, y: videoPlayerView.frame.midY)
             videoPlayerView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            videoPlayerView.clipsToBounds = true
        }
            containerView.addSubview(toView)
            containerView.bringSubview(toFront: videoPlayerView)
            
            UIView.animate(withDuration: duration, delay:0.0,
                           usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0,
                           animations: {
                            videoPlayerView.transform = self.presenting ?
                                CGAffineTransform.identity : scaleTransform
                            videoPlayerView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            },
                           completion: { _ in
                            if !self.presenting{
                                self.dismissCompletion?()
                            }
                            transitionContext.completeTransition(true)
            })
        }
        
        
        
        
    }


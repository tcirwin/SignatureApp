//
//  SignatureView.swift
//  SignatureApp
//
//  Created by Therin Irwin on 8/31/14.
//  Copyright (c) 2014 Therin Irwin. All rights reserved.
//

import UIKit

class SignatureView: UIView {
    // nil indicates that we need to move the pen
    var tracers: CGPoint?[] = [nil]
    
    override func drawRect(rect: CGRect) {
        let signature = UIBezierPath()
        var endLine = true
        
        for tracer in tracers {
            if let tracer = tracer? {
                if endLine {
                    signature.moveToPoint(tracer)
                    endLine = false
                }
                else {
                    signature.addLineToPoint(tracer)
                }
            }
            else {
                endLine = true
            }
        }
        
        UIColor.blackColor().setStroke()
        signature.stroke()
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        tracers.append(nil)
        handleTouch(touches, withEvent: event)
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        handleTouch(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        handleTouch(touches, withEvent: event)
        tracers.append(nil)
    }
    
    func handleTouch(touches: NSSet!, withEvent event: UIEvent!) {
        let touch: UITouch = touches.anyObject() as UITouch
        tracers.append(touch.locationInView(self))
        setNeedsDisplay()
    }
}

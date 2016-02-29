//
//  ImageClippingMaskView.swift
//  ImageClipping
//
//  Created by 胡琰士 on 16/2/29.
//  Copyright © 2016年 胡琰士. All rights reserved.
//

import UIKit

class ImageClippingMaskView: UIView {

    var clippingRect:CGRect? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetRGBFillColor(ctx, 0.1, 0.1, 0.1, 0.6)
        let fillRect = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height - Clipping.FootViewHeight)
        CGContextFillRect(ctx, fillRect)
        CGContextSetStrokeColorWithColor(ctx, Clipping.MaskViewBorderColor.CGColor)
        CGContextStrokeRectWithWidth(ctx, clippingRect!, Clipping.MaskViewBorderWidth)
        CGContextClearRect(ctx, CGRect(x: (clippingRect?.origin.x)!+1, y: (clippingRect?.origin.y)!, width: (clippingRect?.size.width)!-2, height: (clippingRect?.size.height)!))
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

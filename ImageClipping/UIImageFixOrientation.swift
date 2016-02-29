//
//  File.swift
//  ImageClipping
//
//  Created by 胡琰士 on 16/2/29.
//  Copyright © 2016年 胡琰士. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func fixOrientation() ->(UIImage) {
        if self.imageOrientation == UIImageOrientation .Up{
            return self
        }
        
        var transform = CGAffineTransformIdentity
        
        switch self.imageOrientation {
        case .Down , .DownMirrored :
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
            break
        case .Left , .LeftMirrored :
            transform = CGAffineTransformTranslate(transform, self.size.width, 0)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
            break
        case .Right , .RightMirrored :
            transform = CGAffineTransformTranslate(transform, 0, self.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(-M_PI_2))
            break
        default :
            break
            
        }
        switch self.imageOrientation {
        case .UpMirrored , .DownMirrored :
            transform = CGAffineTransformTranslate(transform, self.size.width, 0)
            transform = CGAffineTransformScale(transform, -1, 1)
            break
        case .LeftMirrored , .RightMirrored :
            transform = CGAffineTransformTranslate(transform, self.size.width, 0)
            transform = CGAffineTransformScale(transform, -1, 1)
            break
        default :
            break
        }
        let ctx = CGBitmapContextCreate(nil, Int(self.size.width), Int(self.size.height), CGImageGetBitsPerComponent(self.CGImage), 0, CGImageGetColorSpace(self.CGImage), CGImageGetBitmapInfo(CGImage).rawValue)
        CGContextConcatCTM(ctx, transform)
        switch self.imageOrientation {
        case .Left , .LeftMirrored , .Right , .RightMirrored :
            CGContextDrawImage(ctx, CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width), self.CGImage)
            break
        default :
            CGContextDrawImage(ctx, CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height), self.CGImage)
        }
        let cgimg = CGBitmapContextCreateImage(ctx)
        let img = UIImage(CGImage: cgimg!)
        return img
    }
}
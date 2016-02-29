//
//  ImageClippingController.swift
//  ImageClipping
//
//  Created by 胡琰士 on 16/2/29.
//  Copyright © 2016年 胡琰士. All rights reserved.
//

import UIKit

class ImageClippingController: UIViewController {

    //MARK : - 属性列表
    private var imageView:UIImageView?
    var clippingImage:UIImage? {
        didSet {
            dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
                let imagefixed = self.clippingImage?.fixOrientation()
                while self.imageView == nil {
                    NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate.distantFuture())
                }
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    self.imageView?.image = imagefixed
                })
            }
        }
    }
    //MARK : - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK : -

    //MARK : - 
    //MARK : - 
    //MARK : - 
    //MARK : -
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ImageClippingController.swift
//  ImageClipping
//
//  Created by 胡琰士 on 16/2/29.
//  Copyright © 2016年 胡琰士. All rights reserved.
//

import UIKit
import MBProgressHUD
import SnapKit
struct Clipping {
    static var FootViewHeight:CGFloat = 73
    static var MaskViewBorderColor = UIColor.lightGrayColor()
    static var MaskViewBorderWidth:CGFloat = 2
}
class ImageClippingController: UIViewController {

    //MARK : - 属性列表
    private var imageView:UIImageView?
    private var clippingWidth:CGFloat = 320
    private var clippingHeight:CGFloat = 160
    private var currentScaleIsHeight:Bool = true
    
    var clippingImage:UIImage? {
        didSet {
            dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
                let imagefixed = self.clippingImage?.fixOrientation()
                while self.imageView == nil {
                    NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate.distantFuture())
                }
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    self.imageView?.image = imagefixed
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                })
            }
        }
    }
    //MARK : - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func loadView() {
        super.loadView()
        clippingWidth = 320
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        imageView = UIImageView(frame: CGRectZero)
        imageView?.userInteractionEnabled = true
        scrollView.addSubview(imageView!)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        imageView?.frame = CGRect(x: 0, y: 0, width: (clippingImage?.size.width)!, height: (clippingImage?.size.height)!)
        scrollView.contentSize = (imageView?.frame.size)!
        maskView.frame = scrollView.frame
        let scale = (clippingImage?.size.width)! / (clippingImage?.size.height)!
        if scale > 2 {
            clippingHeight = 160
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK : -
    private lazy var maskView:ImageClippingMaskView = {
       let maskView = ImageClippingMaskView()
        maskView.backgroundColor = UIColor.clearColor()
        maskView.userInteractionEnabled = false
        return maskView
    }()
    private lazy var scrollView:UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.blackColor()
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.maximumZoomScale = 2
        scrollView.bouncesZoom = false
        return scrollView
    }()

    //MARK : - 
    private func heightScale() {
        let scale = clippingHeight / (clippingImage?.size.height)!
        if scale > 1 {
            scrollView.maximumZoomScale = scale + scale
        }
        scrollView.minimumZoomScale = scale
        scrollView.zoomScale = scale
        currentScaleIsHeight = true
    }
    private func widthScale() {
        let scale = scrollView.frame.size.width / (clippingImage?.size.width)!
        if scale > 1 {
            scrollView.minimumZoomScale = scale
            scrollView.zoomScale = scale
            currentScaleIsHeight = false
        }
    }
    private func rectangleStyle() {
        clippingHeight = 160
        if currentScaleIsHeight {
            let scale = scrollView.frame.size.width / (clippingImage?.size.width)!
            if scale > 1 {
                scrollView.maximumZoomScale = scale + scale
            }
            scrollView.minimumZoomScale = scale
            currentScaleIsHeight = false
        }
        maskViewClippingRect()
    }
    private func squareStyle() {
        clippingHeight = 320
        if currentScaleIsHeight == false && clippingImage?.size.width > clippingImage?.size.height {
           let scale = clippingHeight / (clippingImage?.size.height)!
            if scale  > 1 {
                scrollView.maximumZoomScale = scale + scale
            }
            scrollView.minimumZoomScale = scale
            currentScaleIsHeight = true
        }
        if imageView?.frame.size.height < clippingHeight {
            heightScale()
        }
        maskViewClippingRect()
    }
    private func maskViewClippingRect() {
        if imageView?.frame.size.width < clippingWidth {
            widthScale()
        }
        let h = scrollView.frame.size.height
        let borderRect = CGRect(x: 0, y: (h - clippingHeight)/2, width: clippingWidth, height: clippingHeight)
        let y3 = borderRect.origin.y + clippingHeight
        let imageInset = UIEdgeInsets(top: borderRect.origin.y, left: 0, bottom: h - y3, right: 0)
        scrollView.contentInset = imageInset
        maskView.clippingRect = borderRect
    }
    //MARK : - 
    private func cancelCropping() {
        
    }
    private func finishCropping() {
        let zoomScale = 1.0 / scrollView.zoomScale
        let contentOffset = scrollView.contentOffset
        let imageViewOffset = imageView?.frame.origin
        var rect = CGRect()
        rect.origin.x = (contentOffset.x - (imageViewOffset?.x)!) * zoomScale
        rect.origin.y = (contentOffset.y - (scrollView.bounds.size.height - clippingHeight)/2) * zoomScale
        rect.size.width = clippingWidth * zoomScale
        rect.size.height = clippingHeight * zoomScale
        let cr = CGImageCreateWithImageInRect(imageView?.image?.CGImage, rect)
    }
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

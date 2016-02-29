//
//  ViewController.swift
//  ImageClipping
//
//  Created by 胡琰士 on 16/2/24.
//  Copyright © 2016年 胡琰士. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func selectedImage(sender: AnyObject) {
        let alertController = UIAlertController(title: "选择图像", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        let albumAction = UIAlertAction(title: "相册", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            print("相册")
            self.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.imagePickerController()
        }
        let cameraAction = UIAlertAction(title: "相机", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            print("相机")
            self.sourceType = UIImagePickerControllerSourceType.Camera
            self.imagePickerController()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(albumAction)
        //判断是否支持拍照
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            alertController.addAction(cameraAction)
        }
        self.presentViewController(alertController, animated: true , completion: nil)
    }
    func imagePickerController(){
        //跳转到相机或相册
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        //        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        imagePickerController
        self.presentViewController(imagePickerController, animated: true , completion: nil)
    }
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true , completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//        navigationController?.pushViewController(ImageEDViewController(image: image), animated: true)
        
    }


}


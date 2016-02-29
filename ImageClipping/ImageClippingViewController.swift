//
//  ImageClippingViewController.swift
//  ImageClipping
//
//  Created by 胡琰士 on 16/2/24.
//  Copyright © 2016年 胡琰士. All rights reserved.
//

import UIKit

class ImageClippingViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    init(image:UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.imageView = UIImageView(image: image)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    
}
